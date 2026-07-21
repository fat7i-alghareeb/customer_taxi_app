part of '../order_bloc.dart';

/// How long to wait for the backend's `PaymentConfirmed` / `PaymentFailed`
/// SignalR push after the Stripe Payment Sheet returns `success`. If the
/// push does not arrive in this window we fall back to the optimistic
/// "trip booked" state to avoid blocking the UI on a flaky webhook path.
const _kPaymentConfirmationTimeout = Duration(seconds: 15);

extension _BookingHandlers on OrderBloc {
  void _onBookingDetailsBackPressed(
    _BookingDetailsBackPressed event,
    Emitter<OrderState> emit,
  ) {
    emit(
      state.copyWith(
        sheet: state.sheet.copyWith(
          expandedStep: OrderExpandedStep.carSelection,
        ),
        booking: state.booking.copyWith(
          pendingTripResponse: null,
          tripRequestStatus: const BlocStatus.initial(),
          paymentSheetState: const BlocStatus.initial(),
        ),
      ),
    );
  }

  void _onScheduleModeChanged(
    _ScheduleModeChanged event,
    Emitter<OrderState> emit,
  ) {
    if (event.mode == OrderScheduleMode.now) {
      emit(
        state.copyWith(
          booking: state.booking.copyWith(
            scheduleMode: OrderScheduleMode.now,
            scheduledAt: null,
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        booking: state.booking.copyWith(scheduleMode: OrderScheduleMode.later),
      ),
    );
  }

  void _onScheduleTimeChanged(
    _ScheduleTimeChanged event,
    Emitter<OrderState> emit,
  ) {
    if (event.time == null) {
      emit(state.copyWith(booking: state.booking.copyWith(scheduledAt: null)));
      return;
    }

    emit(
      state.copyWith(
        booking: state.booking.copyWith(
          scheduleMode: OrderScheduleMode.later,
          scheduledAt: event.time,
        ),
      ),
    );
  }

  void _onPassengerNoteChanged(
    _PassengerNoteChanged event,
    Emitter<OrderState> emit,
  ) {
    emit(
      state.copyWith(
        booking: state.booking.copyWith(passengerNote: event.note),
      ),
    );
  }

  void _onFlightNumberChanged(
    _FlightNumberChanged event,
    Emitter<OrderState> emit,
  ) {
    emit(
      state.copyWith(
        booking: state.booking.copyWith(flightNumber: event.flightNumber),
      ),
    );
  }

  void _onPaymentSheetDismissed(
    _PaymentSheetDismissed event,
    Emitter<OrderState> emit,
  ) {
    emit(
      state.copyWith(
        booking: state.booking.copyWith(
          paymentSheetState: const BlocStatus.initial(),
        ),
      ),
    );
  }

  Future<void> _onWalletBalanceRequested(
    _WalletBalanceRequested event,
    Emitter<OrderState> emit,
  ) async {
    final result = await _paymentFacade.getWalletBalance();
    if (isClosed) return;
    result.when(
      success: (balance) => emit(
        state.copyWith(
          booking: state.booking.copyWith(
            walletBalance: balance.balance,
            walletCurrency: balance.currencyCode,
          ),
        ),
      ),
      // Ignore failures — the wallet options just won't be offered.
      failure: (_) {},
    );
  }

  void _onPaymentMethodSelected(
    _PaymentMethodSelected event,
    Emitter<OrderState> emit,
  ) {
    emit(
      state.copyWith(
        booking: state.booking.copyWith(paymentMethod: event.method),
      ),
    );
  }

  Future<void> _onConfirmBookingDetailsPressed(
    _ConfirmBookingDetailsPressed event,
    Emitter<OrderState> emit,
  ) async {
    printC('[Payment] confirmBookingDetailsPressed');

    // ── Guard: need a selected quote and ≥2 resolved stops ──────────────────
    final quoteId = state.trip.selectedQuoteId;
    if (quoteId == null) {
      printY('[Payment] blocked — no quote selected');
      return;
    }

    final resolvedStops = state.stops.list
        .whereType<OrderLocationEntity>()
        .toList();
    if (resolvedStops.length < 2) {
      printY(
        '[Payment] blocked — stops not ready (${resolvedStops.length} resolved)',
      );
      return;
    }

    final isAirport = resolvedStops.first.isAirport;
    final normalizedFlightNumber = _normalizeFlightNumber(
      state.booking.flightNumber,
    );
    if (isAirport && !_isValidFlightNumber(normalizedFlightNumber)) {
      printY('[Payment] blocked — invalid airport flight number');
      return;
    }

    // ── Retry path: reuse existing PaymentIntent if user previously dismissed ──
    // When the user opens the Stripe sheet and closes it without paying, the
    // PaymentIntent remains in `requires_payment_method` on Stripe's side —
    // the same clientSecret is still valid. Skip requestTrip and re-present
    // the existing sheet instead of creating a new trip (which would hit the
    // "quote already used" error on the backend).
    final pending = state.booking.pendingTripResponse;
    if (pending?.stripePayment != null) {
      printC('[Payment] retry — reusing existing PI for tripId=${pending!.id}');
      emit(
        state.copyWith(
          booking: state.booking.copyWith(
            tripRequestStatus: const BlocStatus.loading(),
            paymentSheetState: const BlocStatus.loading(),
          ),
        ),
      );
      await _presentStripeSheet(emit, pending, pending.stripePayment!);
      return;
    }

    // ── First attempt: create the trip on the backend ────────────────────────
    printC(
      '[Payment] requesting trip quoteId=$quoteId stops=${resolvedStops.length}',
    );
    emit(
      state.copyWith(
        booking: state.booking.copyWith(
          tripRequestStatus: const BlocStatus.loading(),
        ),
      ),
    );

    final stopCoords = resolvedStops
        .map(
          (s) => OrderStopCoordinateEntity(
            latitude: s.latitude,
            longitude: s.longitude,
            label: s.label,
            isAirport: s.isAirport,
          ),
        )
        .toList();

    final scheduledAtToSend =
        state.booking.scheduleMode == OrderScheduleMode.later
        ? state.booking.scheduledAt
        : null;
    final passengerNote = state.booking.passengerNote.trim();

    if (scheduledAtToSend != null) {
      printC('[Payment] scheduled ride at $scheduledAtToSend');
    }

    final result = await _facade.requestTrip(
      OrderRequestTripEntity(
        quoteId: quoteId,
        stops: stopCoords,
        scheduledAt: scheduledAtToSend,
        passengerNote: passengerNote.isEmpty ? null : passengerNote,
        flightNumber: isAirport ? normalizedFlightNumber : null,
        paymentMethod: state.booking.paymentMethod.apiValue,
      ),
    );

    await result.when(
      success: (trip) async {
        printG('[Payment] requestTrip success tripId=${trip.id}');

        // Join the trip's SignalR group as soon as we have an id so we can
        // observe the backend's PaymentConfirmed / PaymentFailed pushes
        // that follow the Stripe webhook.
        printC('[Payment] joining SignalR group for tripId=${trip.id}');
        unawaited(_realtime.joinTripGroup(trip.id));

        // Block re-booking the instant a trip exists server-side, regardless
        // of payment path below: hides the Home tab's bookable "Now/Later"
        // pill behind a spinner until ActiveTripGate mounts the live trip
        // view (which does the real per-trip SignalR join via TripBloc).
        final activeTripCubit = getIt<ActiveTripCubit>();
        activeTripCubit.markBookingPending();
        unawaited(activeTripCubit.refresh());

        final stripePayment = trip.stripePayment;
        final stripeEnabled = _clientConfig.current.stripeEnabled;

        if (!stripeEnabled) {
          printY(
            '[Payment] Stripe disabled — skipping payment sheet (trip booked)',
          );
          emit(
            state.copyWith(
              booking: state.booking.copyWith(
                tripRequestStatus: BlocStatus.success(trip),
                pendingTripResponse: null,
              ),
            ),
          );
          return;
        }

        if (stripePayment == null) {
          printY(
            '[Payment] stripeEnabled=true but no stripePayment on trip — skipping sheet (trip booked)',
          );
          emit(
            state.copyWith(
              booking: state.booking.copyWith(
                tripRequestStatus: BlocStatus.success(trip),
                pendingTripResponse: null,
              ),
            ),
          );
          return;
        }

        // Store the trip so retries can skip requestTrip and reuse the PI.
        emit(
          state.copyWith(
            booking: state.booking.copyWith(
              pendingTripResponse: trip,
              tripRequestStatus: const BlocStatus.loading(),
              paymentSheetState: const BlocStatus.loading(),
            ),
          ),
        );

        await _presentStripeSheet(emit, trip, stripePayment);
      },
      failure: (message) async {
        printR('[Payment] requestTrip failed: $message');
        emit(
          state.copyWith(
            booking: state.booking.copyWith(
              tripRequestStatus: BlocStatus.failure(message),
            ),
          ),
        );
      },
    );
  }

  /// Initialises and presents the Stripe payment sheet for [trip] using
  /// [stripePayment]. Handles success, cancel, and hard failure outcomes,
  /// updating [emit] accordingly.
  Future<void> _presentStripeSheet(
    Emitter<OrderState> emit,
    OrderTripResponseEntity trip,
    OrderStripePaymentEntity stripePayment,
  ) async {
    printC(
      '[Payment] Stripe path — paymentIntentId=${stripePayment.paymentIntentId}',
    );

    try {
      printC('[Payment] initPaymentSheet — client secret received');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: stripePayment.clientSecret,
          customerId: stripePayment.customerId,
          customerEphemeralKeySecret: stripePayment.ephemeralKeySecret,
          merchantDisplayName: 'customertaxi',
          // Link is suppressed everywhere: riders pay by card / iDEAL / Klarna,
          // and the extra Link step confused them. Note the sheet's language is
          // NOT controllable from Dart — flutter_stripe exposes no locale
          // parameter, so the native sheet follows the device language rather
          // than the in-app one. Changing that needs native per-app locale work.
          linkDisplayParams: const LinkDisplayParams(
            linkDisplay: LinkDisplay.never,
          ),
          style: ThemeMode.system,
          returnURL: 'customertaxi://stripe-redirect',
          billingDetailsCollectionConfiguration:
              const BillingDetailsCollectionConfiguration(
                email: CollectionMode.automatic,
                name: CollectionMode.automatic,
                address: AddressCollectionMode.automatic,
              ),
        ),
      );
      printG('[Payment] initPaymentSheet done');

      printC('[Payment] presentPaymentSheet — waiting for user');
      await Stripe.instance.presentPaymentSheet();
      printG('[Payment] presentPaymentSheet returned success (local)');

      // Sheet returned success locally, but the trip is still in
      // `AwaitingPayment` on the server until the Stripe webhook fires.
      // Wait briefly for the real-time confirmation push before
      // declaring success in the UI.
      printC(
        '[Payment] awaiting backend PaymentConfirmed/PaymentFailed (timeout=${_kPaymentConfirmationTimeout.inSeconds}s)',
      );
      final outcome = await _awaitPaymentOutcome(trip.id);
      switch (outcome) {
        case _PaymentOutcome.confirmed:
          printG('[Payment] backend confirmed — emitting success');
          emit(
            state.copyWith(
              booking: state.booking.copyWith(
                paymentSheetState: const BlocStatus.success(null),
                pendingTripResponse: null,
              ),
            ),
          );
          break;
        case _PaymentOutcome.timeout:
          // No confirmation push in time — reconcile against the authoritative trip
          // status before declaring success, so a genuinely failed async payment
          // (e.g. iDEAL that later fails) doesn't surface as a booked ride.
          final reconciled = await _reconcilePaymentStatus(trip.id);
          if (reconciled == _PaymentOutcome.failed) {
            printR('[Payment] reconcile: backend reports payment failed');
            emit(
              state.copyWith(
                booking: state.booking.copyWith(
                  tripRequestStatus: BlocStatus.failure(
                    AppStrings.paymentFailed,
                  ),
                  paymentSheetState: const BlocStatus.initial(),
                  pendingTripResponse: null,
                ),
              ),
            );
          } else {
            printY(
              '[Payment] reconcile inconclusive/confirmed — optimistic success',
            );
            emit(
              state.copyWith(
                booking: state.booking.copyWith(
                  paymentSheetState: const BlocStatus.success(null),
                  pendingTripResponse: null,
                ),
              ),
            );
          }
          break;
        case _PaymentOutcome.failed:
          printR(
            '[Payment] backend reported payment failed — emitting failure',
          );
          // Payment definitively failed on the backend side; clear the pending
          // trip so the next tap creates a fresh one.
          emit(
            state.copyWith(
              booking: state.booking.copyWith(
                tripRequestStatus: BlocStatus.failure(AppStrings.paymentFailed),
                paymentSheetState: const BlocStatus.initial(),
                pendingTripResponse: null,
              ),
            ),
          );
          break;
      }
    } on StripeException catch (e) {
      final isCanceled = e.error.code == FailureCode.Canceled;
      if (isCanceled) {
        printY(
          '[Payment] sheet canceled by user — keeping PI for retry code=${e.error.code}',
        );
        // Keep pendingTripResponse: the PaymentIntent is still in
        // `requires_payment_method` on Stripe's side and can be re-presented.
        emit(
          state.copyWith(
            booking: state.booking.copyWith(
              tripRequestStatus: BlocStatus.failure(AppStrings.paymentCanceled),
              paymentSheetState: const BlocStatus.initial(),
            ),
          ),
        );
      } else {
        printR(
          '[Payment] sheet hard failure — keeping PI for retry code=${e.error.code} msg=${e.error.localizedMessage}',
        );
        // Keep pendingTripResponse so the user can reopen the sheet. The backend
        // makes POST /trips idempotent (it returns the same AwaitingPayment trip
        // with a freshly issued PaymentIntent when the quote is already used), so
        // retrying is safe whether we re-present the cached intent or re-request.
        emit(
          state.copyWith(
            booking: state.booking.copyWith(
              tripRequestStatus: BlocStatus.failure(AppStrings.paymentFailed),
              paymentSheetState: const BlocStatus.initial(),
            ),
          ),
        );
      }
    }
  }

  /// Waits up to [_kPaymentConfirmationTimeout] for the backend's
  /// `PaymentConfirmed` or `PaymentFailed` SignalR push for [tripId].
  ///
  /// Returns:
  /// - [_PaymentOutcome.confirmed] on `PaymentConfirmed`
  /// - [_PaymentOutcome.failed] on `PaymentFailed`
  /// - [_PaymentOutcome.timeout] if neither arrives in time (caller treats
  ///   this as an optimistic success to keep the UI responsive)
  Future<_PaymentOutcome> _awaitPaymentOutcome(String tripId) async {
    printC(
      '[Payment/_awaitOutcome] listening for tripId=$tripId timeout=${_kPaymentConfirmationTimeout.inSeconds}s',
    );
    try {
      final event = await _realtime.events
          .where(
            (e) =>
                e.tripId == tripId &&
                (e is RealtimePaymentConfirmed || e is RealtimePaymentFailed),
          )
          .first
          .timeout(_kPaymentConfirmationTimeout);

      if (event is RealtimePaymentFailed) {
        printR(
          '[Payment/_awaitOutcome] PaymentFailed received reason=${event.reason}',
        );
        return _PaymentOutcome.failed;
      }
      printG('[Payment/_awaitOutcome] PaymentConfirmed received');
      return _PaymentOutcome.confirmed;
    } on TimeoutException {
      printY(
        '[Payment/_awaitOutcome] no push within ${_kPaymentConfirmationTimeout.inSeconds}s — optimistic success',
      );
      return _PaymentOutcome.timeout;
    }
  }

  /// After a confirmation timeout, fetch the authoritative trip status. Returns
  /// [_PaymentOutcome.failed] only when the backend definitively marked the
  /// payment failed; otherwise `confirmed`/`timeout` (both treated as optimistic
  /// success by the caller) so a merely slow webhook or an unreachable fetch
  /// still keeps the UI responsive.
  Future<_PaymentOutcome> _reconcilePaymentStatus(String tripId) async {
    printC('[Payment/_reconcile] fetching trip status tripId=$tripId');
    final result = await getIt<TripFacade>().getTripById(tripId);
    return result.when(
      success: (trip) {
        switch (trip.status) {
          case TripStatus.paymentFailed:
            return _PaymentOutcome.failed;
          case TripStatus.awaitingPayment:
            // Card charged locally; the confirming webhook is still pending.
            return _PaymentOutcome.timeout;
          default:
            return _PaymentOutcome.confirmed;
        }
      },
      failure: (_) => _PaymentOutcome.timeout,
    );
  }
}

String _normalizeFlightNumber(String value) {
  return value.trim().replaceAll(RegExp(r'\s+'), ' ').toUpperCase();
}

bool _isValidFlightNumber(String value) {
  return value.length >= 2 &&
      value.length <= 15 &&
      RegExp(r'^[A-Z0-9](?:[A-Z0-9 -]{0,13}[A-Z0-9])?$').hasMatch(value);
}

enum _PaymentOutcome { confirmed, failed, timeout }
