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
    TripEvent.editPreviewRequested(stops: stops, passengerCount: passengerCount),
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

  // 3) Apply + settle.
  bloc.add(
    TripEvent.editApplyRequested(
      stops: stops,
      passengerCount: passengerCount,
      expectedDelta: preview.delta,
    ),
  );
  final applyState = await bloc.stream.firstWhere(
    (s) => s.editApplyStatus.isSuccess || s.editApplyStatus.isFailed,
  );
  if (!context.mounted) return;

  final result = applyState.editApplyStatus.getDataWhenSuccess;
  if (result == null) {
    showErrorOverlay(context, _mapError(applyState.editApplyStatus.errorMessage));
    bloc.add(const TripEvent.editStatusReset());
    return;
  }

  // 4) Interactive PaymentSheet fallback (higher fare, no usable saved card).
  if (result.requiresPaymentSheet) {
    await _presentPaymentSheet(context, result);
  }

  if (context.mounted) bloc.add(const TripEvent.editStatusReset());
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

Future<void> _presentPaymentSheet(
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
        style: ThemeMode.system,
        returnURL: 'customertaxi://stripe-redirect',
      ),
    );
    await Stripe.instance.presentPaymentSheet();
    // Success: the backend applies the held edit via webhook; the trip refreshes
    // over realtime. No local mutation needed here.
  } on StripeException catch (e) {
    // Dismissing the sheet abandons the edit — the backend reverts it (no change).
    if (e.error.code == FailureCode.Canceled) return;
    if (context.mounted) {
      showErrorOverlay(context, AppStrings.tripEditPaymentDeclined);
    }
  } catch (_) {
    if (context.mounted) {
      showErrorOverlay(context, AppStrings.tripEditPaymentDeclined);
    }
  }
}

String _mapError(String? message) {
  if (message == null || message.isEmpty) return AppStrings.tripEditFailed;
  if (message.contains(_deltaChangedCode) ||
      message.contains('DeltaChanged')) {
    return AppStrings.tripEditDeltaChanged;
  }
  return message;
}
