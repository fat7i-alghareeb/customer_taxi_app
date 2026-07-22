import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_edit_apply_result_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_edit_preview_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';

/// Server error code surfaced when the re-quoted delta no longer matches the
/// value the customer confirmed (quote expired / concurrent edit).
const _deltaChangedCode = 'Trip.Edit.DeltaChanged';

/// Runs the mid-trip re-pricing edit: preview the fare difference, confirm it in a
/// dialog, apply it, and — when a fare increase can't be charged silently — present
/// the Stripe PaymentSheet. Cancelling the sheet leaves the trip unchanged (the
/// backend reverts the held edit); a realtime refresh reflects a successful change.
Future<void> runTripEditFlow(
  BuildContext context, {
  required TripBloc bloc,
  List<TripStopEntity>? stops,
  int? passengerCount,
}) async {
  bloc.add(const TripEvent.editStatusReset());

  // 1) Preview (no mutation).
  bloc.add(
    TripEvent.editPreviewRequested(
      stops: stops,
      passengerCount: passengerCount,
    ),
  );
  final previewState = await bloc.stream.firstWhere(
    (s) => s.editPreviewStatus.isSuccess || s.editPreviewStatus.isFailed,
  );
  if (!context.mounted) return;

  final preview = previewState.editPreviewStatus.getDataWhenSuccess;
  if (preview == null) {
    showErrorOverlay(
      context,
      _mapError(previewState.editPreviewStatus.errorMessage),
    );
    bloc.add(const TripEvent.editStatusReset());
    return;
  }

  // 2) Confirm the difference.
  final confirmed = await _showDeltaDialog(context, preview);
  if (confirmed != true) {
    if (context.mounted) bloc.add(const TripEvent.editStatusReset());
    return;
  }
  if (!context.mounted) return;

  // 3) Apply + settle. The preview token pins the server to the quote just shown, so the
  //    amount charged is the amount confirmed above.
  bloc.add(
    TripEvent.editApplyRequested(
      stops: stops,
      passengerCount: passengerCount,
      expectedDelta: preview.delta,
      previewToken: preview.previewToken,
    ),
  );
  final applyState = await bloc.stream.firstWhere(
    (s) => s.editApplyStatus.isSuccess || s.editApplyStatus.isFailed,
  );
  if (!context.mounted) return;

  final result = applyState.editApplyStatus.getDataWhenSuccess;
  if (result == null) {
    showErrorOverlay(
      context,
      _mapError(applyState.editApplyStatus.errorMessage),
    );
    bloc.add(const TripEvent.editStatusReset());
    return;
  }

  // 4) Interactive PaymentSheet fallback (higher fare, no usable saved card).
  if (result.requiresPaymentSheet) {
    final paid = await _presentPaymentSheet(context, result);
    if (!context.mounted) return;
    bloc.add(const TripEvent.editStatusReset());
    if (paid) {
      // The edit is applied by the Stripe webhook, not by the call we just made, so the
      // trip in hand is still the pre-edit one. Poll for the committed version rather
      // than leaving the old details on screen — realtime is the fast path, not the only
      // one, and it was previously the only one.
      showLoadingOverlay(context, AppStrings.tripEditConfirmingPayment);
      bloc.add(const TripEvent.pollingTick());
    }
    return;
  }

  // 5) Settled silently (wallet / saved card) — the money already moved, so say so.
  //    Leaving this silent is what made customers think nothing had been charged.
  //    The wallet balance needs no nudge here: PaymentBloc is a factory and the wallet
  //    screen refetches on open, so there is no shared instance holding a stale figure.
  _showSettlementConfirmation(context, result);
  bloc.add(const TripEvent.editStatusReset());
}

/// Confirms what a committed edit cost. [delta] > 0 was charged, < 0 is being refunded.
void _showSettlementConfirmation(
  BuildContext context,
  TripEditApplyResultEntity result,
) {
  final amount = '${result.delta.abs().toStringAsFixed(2)} ${result.currency}';
  final total = result.trip == null
      ? null
      : '${result.trip!.quotedFare.toStringAsFixed(2)} ${result.trip!.currencyCode}';

  if (result.delta == 0 || total == null) {
    showSuccessOverlay(context, AppStrings.tripEditAppliedNoChange);
    return;
  }

  final key = result.delta > 0
      ? 'tripEditChargedConfirm'
      : 'tripEditRefundedConfirm';
  showSuccessOverlay(
    context,
    key.tr(namedArgs: {'amount': amount, 'total': total}),
  );
}

Future<bool?> _showDeltaDialog(
  BuildContext context,
  TripEditPreviewEntity preview,
) {
  final amountText =
      '${preview.absoluteDelta.toStringAsFixed(2)} ${preview.currency}';

  final String title;
  final String message;
  if (preview.isCharge) {
    title = AppStrings.tripEditPayMoreTitle;
    message = 'tripEditPayMoreMessage'.tr(namedArgs: {'amount': amountText});
  } else if (preview.isRefund) {
    title = AppStrings.tripEditRefundTitle;
    message = 'tripEditRefundMessage'.tr(namedArgs: {'amount': amountText});
  } else {
    title = AppStrings.tripEditConfirm;
    message = AppStrings.tripEditNoChange;
  }

  final vehicleNotice = preview.vehicleChanged
      ? '\n\n${'tripEditVehicleChangedNotice'.tr(namedArgs: {'vehicle': preview.newVehicleTypeName!})}'
      : '';

  return AppDialog.show<bool>(
    context,
    dialog: AppDialog.basic(
      title: title,
      message: '$message$vehicleNotice',
      primaryAction: AppDialogAction.primary(
        label: AppStrings.tripEditConfirm,
        onPressed: () => Navigator.of(context).pop(true),
      ),
      secondaryAction: AppDialogAction.secondary(
        label: AppStrings.cancel,
        onPressed: () => Navigator.of(context).pop(false),
      ),
    ),
  );
}

/// Returns true when the customer completed the sheet, so the caller knows to wait for the
/// webhook-applied trip rather than assuming nothing changed.
Future<bool> _presentPaymentSheet(
  BuildContext context,
  TripEditApplyResultEntity result,
) async {
  final sheet = result.paymentSheet!;
  try {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: sheet.clientSecret,
        customerId: sheet.customerId,
        customerEphemeralKeySecret: sheet.ephemeralKeySecret,
        merchantDisplayName: 'customertaxi',
        linkDisplayParams: const LinkDisplayParams(
          linkDisplay: LinkDisplay.never,
        ),
        style: ThemeMode.system,
        returnURL: 'customertaxi://stripe-redirect',
        // Mirror the first-booking sheet so the edit sheet looks identical.
        billingDetailsCollectionConfiguration:
            const BillingDetailsCollectionConfiguration(
              email: CollectionMode.automatic,
              name: CollectionMode.automatic,
              address: AddressCollectionMode.automatic,
            ),
      ),
    );
    await Stripe.instance.presentPaymentSheet();
    // Paid. The backend applies the held edit from the webhook, so the change lands
    // shortly after this returns — the caller refreshes rather than assuming.
    return true;
  } on StripeException catch (e) {
    // Dismissing the sheet abandons the edit — the backend reverts it (no change).
    if (e.error.code == FailureCode.Canceled) return false;
    if (context.mounted) {
      showErrorOverlay(context, AppStrings.tripEditPaymentDeclined);
    }
    return false;
  } catch (_) {
    if (context.mounted) {
      showErrorOverlay(context, AppStrings.tripEditPaymentDeclined);
    }
    return false;
  }
}

String _mapError(String? message) {
  if (message == null || message.isEmpty) return AppStrings.tripEditFailed;
  if (message.contains(_deltaChangedCode) || message.contains('DeltaChanged')) {
    return AppStrings.tripEditDeltaChanged;
  }
  return message;
}
