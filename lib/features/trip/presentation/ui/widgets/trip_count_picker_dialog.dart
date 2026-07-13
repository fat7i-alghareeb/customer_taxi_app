import 'package:customertaxi/common/imports/imports.dart';

/// Shows a simple +/- count picker dialog and returns the chosen value (or null
/// if dismissed). Shared by the confirmation / en-route / arrived edit flows.
Future<int?> showTripCountPicker(
  BuildContext context, {
  required String title,
  required int initial,
  required int min,
  required int max,
}) {
  return showDialog<int>(
    context: context,
    builder: (_) => TripCountPickerDialog(
      title: title,
      initial: initial,
      min: min,
      max: max,
    ),
  );
}

class TripCountPickerDialog extends StatefulWidget {
  const TripCountPickerDialog({
    required this.title,
    required this.initial,
    required this.min,
    required this.max,
    super.key,
  });

  final String title;
  final int initial;
  final int min;
  final int max;

  @override
  State<TripCountPickerDialog> createState() => _TripCountPickerDialogState();
}

class _TripCountPickerDialogState extends State<TripCountPickerDialog> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return AlertDialog(
      title: Text(widget.title, style: AppTextStyles.s16w700),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _value > widget.min
                ? () => setState(() => _value--)
                : null,
            icon: const Icon(Icons.remove_circle_outline),
            color: colors.primary,
            iconSize: 32.r,
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              '$_value',
              style: AppTextStyles.s24w700.copyWith(color: colors.onSurface),
            ),
          ),
          IconButton(
            onPressed: _value < widget.max
                ? () => setState(() => _value++)
                : null,
            icon: const Icon(Icons.add_circle_outline),
            color: colors.primary,
            iconSize: 32.r,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_value),
          child: Text(AppStrings.confirm),
        ),
      ],
    );
  }
}
