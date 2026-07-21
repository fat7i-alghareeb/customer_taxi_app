import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/trip/domain/facade/trip_facade.dart';

/// Fetches the outstanding waiting fee for [tripId] and, if any, opens the
/// Stripe payment sheet so the passenger can settle it on-session. Used both
/// from the "waiting fee due" notification and an in-app button.
Future<void> showWaitingFeeSettlement(
  BuildContext context, {
  required String tripId,
}) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  final result = await getIt<TripFacade>().settleWaitingFee(tripId);

  if (context.mounted) {
    Navigator.of(context, rootNavigator: true).pop(); // dismiss the loader
  }

  await result.when(
    success: (settlement) async {
      if (!settlement.hasOutstanding) {
        if (context.mounted) {
          showSuccessOverlay(context, AppStrings.waitingFeeNothingDue);
        }
        return;
      }

      final sp = settlement.stripePayment!;
      try {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: sp.clientSecret,
            customerId: sp.customerId,
            customerEphemeralKeySecret: sp.ephemeralKeySecret,
            merchantDisplayName: 'customertaxi',
            linkDisplayParams: const LinkDisplayParams(
              linkDisplay: LinkDisplay.never,
            ),
            style: ThemeMode.system,
            returnURL: 'customertaxi://stripe-redirect',
          ),
        );
        await Stripe.instance.presentPaymentSheet();
        if (context.mounted) {
          showSuccessOverlay(context, AppStrings.waitingFeePaidSuccess);
        }
      } on StripeException catch (e) {
        // User dismissing the sheet is not an error.
        if (e.error.code == FailureCode.Canceled) return;
        if (context.mounted) {
          showErrorOverlay(context, AppStrings.waitingFeePayFailed);
        }
      } catch (_) {
        if (context.mounted) {
          showErrorOverlay(context, AppStrings.waitingFeePayFailed);
        }
      }
    },
    failure: (message) async {
      if (context.mounted) showErrorOverlay(context, message);
    },
  );
}
