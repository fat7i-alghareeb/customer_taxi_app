import 'package:customertaxi/common/imports/imports.dart';

import 'root_map_recenter_button_widget.dart';
import 'root_map_zoom_buttons_widget.dart';

class RootMapControlsSection extends StatelessWidget {
  const RootMapControlsSection({
    super.key,
    required this.onRecenterTap,
    required this.onZoomInTap,
    required this.onZoomOutTap,
    required this.recenterLoading,
  });

  final VoidCallback onRecenterTap;
  final VoidCallback onZoomInTap;
  final VoidCallback onZoomOutTap;
  final bool recenterLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RootMapRecenterButtonWidget(
          onTap: onRecenterTap,
          isLoading: recenterLoading,
        ),
        AppSpacing.md.verticalSpace,
        RootMapZoomButtonsWidget(
          onZoomInTap: onZoomInTap,
          onZoomOutTap: onZoomOutTap,
        ),
      ],
    );
  }
}
