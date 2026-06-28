import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/services/support_contact/support_contact_service.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/record_ride_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/safety_action.dart';
import 'package:url_launcher/url_launcher.dart';

class InTripSafetyPanel extends StatelessWidget {
  const InTripSafetyPanel({
    required this.tripId,
    super.key,
  });

  final String tripId;

  Future<void> _launch(Uri uri) async {
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      printY('[InTripSafetyPanel] safety launch failed uri=$uri error=$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: SafetyAction(
                icon: Icons.shield_rounded,
                label: AppStrings.inTripEmergencyHelp,
                onTap: () => _launch(Uri.parse('tel:112')),
              ),
            ),
            Expanded(
              child: SafetyAction(
                icon: Icons.mic_rounded,
                label: AppStrings.inTripRecordRide,
                onTap: () => RecordRideSheet.show(context, tripId: tripId),
              ),
            ),
            Expanded(
              child: SafetyAction(
                icon: Icons.flag_rounded,
                label: AppStrings.inTripReportProblem,
                onTap: () {
                  final number = getIt<SupportContactService>().whatsApp;
                  _launch(Uri.parse('https://wa.me/$number'));
                },
              ),
            ),
          ],
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          AppStrings.inTripSafetyTagline,
          textAlign: TextAlign.center,
          style: AppTextStyles.s11w500.copyWith(
            color: colors.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
