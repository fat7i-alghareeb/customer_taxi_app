import 'package:customertaxi/common/imports/imports.dart';

import '../../../domain/entities/trip_entity.dart';
import '../../../domain/entities/trip_refund_status.dart';
import '../../../domain/entities/trip_status.dart';
import '../../states/trip_bloc.dart';
import '../widgets/completed_action_chips.dart';
import '../widgets/refund/cancelled_trip_refund_section.dart';
import '../widgets/refund/trip_refund_status_card.dart';
import '../widgets/trip_fare_summary_card.dart';
import '../widgets/trip_rating_sheet.dart';
import '../widgets/trip_stops_timeline.dart';

/// Post-trip details screen — replicates the Uber "تفاصيل المشوار" reference
/// image. Reached by tapping a completed trip card in trip history; renders
/// the same chips and timeline used by the inline completion sheet.
class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  static const String pagePath = '/trip_details';
  static const String pageName = 'TripDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final tripId =
        (state.extra as String?) ?? state.uri.queryParameters['id'] ?? '';

    return BlocProvider<TripBloc>(
      create: (_) => getIt<TripBloc>()..add(TripEvent.started(tripId)),
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(
          title: AppStrings.tripDetailsTitle,
        ),
        child: _TripDetailsBody(tripId: tripId),
      ),
    );
  }
}

class _TripDetailsBody extends StatelessWidget {
  const _TripDetailsBody({required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (a, b) => a.tripStatus != b.tripStatus,
      builder: (context, state) {
        return StatusBuilder<TripEntity>(
          state: state.tripStatus,
          onError: () =>
              context.read<TripBloc>().add(TripEvent.started(tripId)),
          success: (trip) => _DetailsContent(trip: trip),
        );
      },
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({required this.trip});

  final TripEntity trip;

  /// Real refund status when the backend has one; otherwise a neutral
  /// "being prepared" state when a cancellation owes a policy amount but no
  /// refund record exists yet. Null when there is nothing refund-related.
  TripRefundEntity? _refundToShow(TripEntity trip) {
    if (trip.refund != null) return trip.refund;
    final cancellation = trip.cancellation;
    if (cancellation != null && cancellation.refundAmount > 0) {
      return TripRefundEntity(
        status: TripRefundStatus.preparing,
        amount: cancellation.refundAmount,
        currencyCode: cancellation.currencyCode,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final completedAt = trip.stops.isNotEmpty
        ? trip.stops.last.completedAtUtc
        : null;

    return SingleChildScrollView(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Chips row — only for completed (paid) trips
          if (trip.status == TripStatus.completed)
            CompletedActionChips(tripId: trip.id),

          // Rating section — CTA when unrated, given stars + edit when rated.
          if (trip.status == TripStatus.completed) ...[
            AppSpacing.lg.verticalSpace,
            _RatingSection(trip: trip),
          ],

          // Prominent, standalone refund outcome (completed / in progress /
          // failed). Falls back to a neutral "being prepared" state when a
          // cancellation owes a policy amount but no refund record exists yet.
          if (_refundToShow(trip) case final refund?) ...[
            AppSpacing.lg.verticalSpace,
            TripRefundStatusCard(refund: refund),
          ],

          if (trip.status == TripStatus.cancelled &&
              trip.cancellation != null) ...[
            AppSpacing.lg.verticalSpace,
            _CancellationSection(trip: trip),
            AppSpacing.lg.verticalSpace,
            CancelledTripRefundSection(trip: trip),
          ],

          AppSpacing.xl.verticalSpace,

          // Stops timeline (pickup, intermediate, destination)
          if (trip.stops.isNotEmpty) ...[
            TripStopsTimeline(stops: trip.stops),
            AppSpacing.lg.verticalSpace,
          ],

          // Fare card
          TripFareSummaryCard(
            amount: trip.quotedFare,
            currencyCode: trip.currencyCode,
            referenceCode: trip.referenceCode,
          ),

          AppSpacing.lg.verticalSpace,
          _DetailsMetaRow(
            icon: FontAwesomeIcons.carSide,
            label: trip.vehicleTypeName ?? '',
          ),
          if (completedAt != null) ...[
            AppSpacing.md.verticalSpace,
            _DetailsMetaRow(
              icon: FontAwesomeIcons.clock,
              label:
                  '${completedAt.toLocal().toYmd()} • ${completedAt.toLocal().toTime12Compact()}',
            ),
          ],
          AppSpacing.md.verticalSpace,
          Text(
            AppStrings.tripReferenceCode.replaceAll(
              '#{code}',
              trip.referenceCode,
            ),
            style: AppTextStyles.s12w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Rating block on a completed trip: a prominent CTA when the rider hasn't
/// rated yet, otherwise the stars they gave plus an option to change them.
class _RatingSection extends StatelessWidget {
  const _RatingSection({required this.trip});

  final TripEntity trip;

  Future<void> _openSheet(BuildContext context) async {
    await showTripRatingSheet(context, tripId: trip.id);
    if (context.mounted) {
      context.read<TripBloc>().add(TripEvent.started(trip.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final rating = trip.passengerRating;

    if (rating == null) {
      // Not rated yet — prominent brand CTA.
      return Material(
        color: colors.primary,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          onTap: () => _openSheet(context),
          child: Padding(
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.solidStar,
                  size: 18.r,
                  color: colors.onPrimary,
                ),
                AppSpacing.md.horizontalSpace,
                Text(
                  AppStrings.rateTripCta,
                  style: AppTextStyles.s14w600.copyWith(
                    color: colors.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Already rated — read-only. A rating is final, so there is no way back in.
    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: colors.onSurface.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.ratingYourRating,
                  style: AppTextStyles.s12w400.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                AppSpacing.sm.verticalSpace,
                _ReadOnlyStars(value: rating),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadOnlyStars extends StatelessWidget {
  const _ReadOnlyStars({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < value;
        return Padding(
          padding: REdgeInsets.only(right: AppSpacing.xs),
          child: FaIcon(
            filled ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
            size: 18.r,
            color: filled
                ? AppColors.warning
                : colors.onSurface.withValues(alpha: 0.25),
          ),
        );
      }),
    );
  }
}

class _DetailsMetaRow extends StatelessWidget {
  const _DetailsMetaRow({required this.icon, required this.label});

  final FaIconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    if (label.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        FaIcon(
          icon,
          size: 16.r,
          color: colors.onSurface.withValues(alpha: 0.6),
        ),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.s14w400.copyWith(color: colors.onSurface),
          ),
        ),
      ],
    );
  }
}

class _CancellationSection extends StatelessWidget {
  const _CancellationSection({required this.trip});

  final TripEntity trip;

  static String _localizeReason(String reason) => switch (reason) {
    'PassengerWithinOneHour' =>
      AppStrings.cancellationReasonPassengerWithinOneHour,
    'DriverLateClaim' => AppStrings.cancellationReasonDriverLateClaim,
    'PassengerLate' => AppStrings.cancellationReasonPassengerLate,
    'PassengerNoShow' => AppStrings.cancellationReasonPassengerNoShow,
    'PassengerUnreachable' => AppStrings.cancellationReasonPassengerUnreachable,
    'AdminOverride' => AppStrings.cancellationReasonAdminOverride,
    'PassengerAfterOneHour' =>
      AppStrings.cancellationReasonPassengerAfterOneHour,
    'AirportWaitDeclined' => AppStrings.cancellationReasonAirportWaitDeclined,
    'PassengerCancelledAfterArrival' =>
      AppStrings.cancellationReasonPassengerCancelledAfterArrival,
    'PassengerWithinFiveMinutes' =>
      AppStrings.cancellationReasonPassengerWithinFiveMinutes,
    'PassengerAfterFiveMinutes' =>
      AppStrings.cancellationReasonPassengerAfterFiveMinutes,
    _ => reason,
  };

  static String _localizeActor(String actor) => switch (actor) {
    'Passenger' => AppStrings.cancellationActorPassenger,
    'Driver' => AppStrings.cancellationActorDriver,
    'Admin' => AppStrings.cancellationActorAdmin,
    _ => actor,
  };

  static String? _localizeNote(String? note) {
    if (note == null) return null;
    return switch (note) {
      'Driver too far or taking too long' =>
        AppStrings.cancelReasonDriverTooLong,
      'Booked by mistake' => AppStrings.cancelReasonBookedByMistake,
      'Plans changed' => AppStrings.cancelReasonPlansChanged,
      'Found another ride' => AppStrings.cancelReasonFoundAnother,
      'Other' => AppStrings.cancelReasonOther,
      _ => note,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final cancel = trip.cancellation!;
    final localizedNote = _localizeNote(cancel.note);

    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: colors.error.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.circleXmark,
                size: 16.r,
                color: colors.error,
              ),
              AppSpacing.md.horizontalSpace,
              Text(
                AppStrings.cancellationPolicyCancellationHeading,
                style: AppTextStyles.s14w700.copyWith(color: colors.error),
              ),
            ],
          ),
          AppSpacing.sm.verticalSpace,
          Text(
            _localizeReason(cancel.reason),
            style: AppTextStyles.s14w600.copyWith(
              color: colors.onSurface.withValues(alpha: 0.8),
            ),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            '${AppStrings.cancellationCancelledByLabel}: ${_localizeActor(cancel.actor)}',
            style: AppTextStyles.s12w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
            ),
          ),
          if (localizedNote != null && localizedNote.isNotEmpty) ...[
            AppSpacing.xs.verticalSpace,
            Text(
              localizedNote,
              style: AppTextStyles.s12w400.copyWith(
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
