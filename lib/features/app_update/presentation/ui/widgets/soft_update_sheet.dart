import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/core/services/app_version/app_version_gate_coordinator.dart';

import 'soft_update_sheet_content_widget.dart';

/// Dismissible nudge shown once per cold start when a newer version exists.
///
/// Dismissible by barrier tap, drag and the explicit "Not now" action — the
/// exact opposite of the force screen, which cannot be dismissed at all.
/// Nothing is persisted: dying with the process is precisely the required
/// "reappear on every cold start" behaviour.
Future<void> showSoftUpdateSheet(BuildContext context) {
  final coordinator = getIt<AppVersionGateCoordinator>();

  return AppBottomSheet.show<void>(
    context,
    sheet: AppBottomSheet.basic(
      child: Builder(
        builder: (sheetContext) => SoftUpdateSheetContentWidget(
          latestVersion: coordinator.latestVersion,
          hasStoreUrl: coordinator.hasStoreUrl,
          onUpdate: () async {
            final launched = await coordinator.openStore();
            if (!sheetContext.mounted) return;

            if (!launched) {
              printY('[SoftUpdateSheet] store launch failed');
              showErrorOverlay(
                sheetContext,
                AppStrings.forceUpdateStoreOpenFailed,
              );
              return;
            }

            Navigator.of(sheetContext).maybePop();
          },
          onDismiss: () => Navigator.of(sheetContext).maybePop(),
        ),
      ),
    ),
  );
}
