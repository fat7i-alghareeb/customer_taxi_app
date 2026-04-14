import 'package:customertaxi/common/imports/imports.dart';

import 'root_map_recenter_button_widget.dart';

class RootMapControlsSection extends StatelessWidget {
  const RootMapControlsSection({
    super.key,
    required this.onRecenterTap,
    required this.recenterLoading,
  });

  final VoidCallback onRecenterTap;
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
      ],
    );
  }
}
