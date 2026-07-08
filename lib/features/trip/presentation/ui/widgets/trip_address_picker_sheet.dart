import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_request_entity.dart';
import 'package:customertaxi/features/order/domain/facade/order_facade.dart';

/// Shows a search sheet and returns the selected [OrderLocationEntity], or null
/// if the user dismissed without selecting.
Future<OrderLocationEntity?> showTripAddressPickerSheet(
  BuildContext context, {
  String? title,
}) {
  return AppBottomSheet.show<OrderLocationEntity>(
    context,
    sheet: AppBottomSheet.basic(
      title: title,
      child: _TripAddressPickerContent(facade: getIt<OrderFacade>()),
    ),
  );
}

class _TripAddressPickerContent extends StatefulWidget {
  const _TripAddressPickerContent({required this.facade});

  final OrderFacade facade;

  @override
  State<_TripAddressPickerContent> createState() =>
      _TripAddressPickerContentState();
}

class _TripAddressPickerContentState extends State<_TripAddressPickerContent> {
  final _controller = TextEditingController();
  Timer? _debounce;
  List<OrderLocationEntity> _results = [];
  bool _loading = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      setState(() {
        _results = [];
        _loading = false;
      });
      return;
    }
    setState(() => _loading = true);
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      if (!mounted) return;
      final result = await widget.facade.searchLocations(
        OrderLocationSearchRequestEntity(query: query.trim()),
      );
      if (!mounted) return;
      result.when(
        success: (locations) => setState(() {
          _results = locations;
          _loading = false;
        }),
        failure: (_) => setState(() {
          _results = [];
          _loading = false;
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _onQueryChanged,
          decoration: InputDecoration(
            hintText: AppStrings.tripEditAddress,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _loading
                ? Padding(
                    padding: REdgeInsets.all(AppSpacing.sm),
                    child: SizedBox(
                      width: 16.r,
                      height: 16.r,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.primary,
                      ),
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.md.r),
            ),
          ),
        ),
        AppSpacing.sm.verticalSpace,
        if (_results.isNotEmpty)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _results.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final location = _results[index];
              return ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.locationDot,
                  size: 16.r,
                  color: colors.primary,
                ),
                title: Text(location.label, style: AppTextStyles.s14w500),
                onTap: () => Navigator.of(context).pop(location),
              );
            },
          ),
      ],
    );
  }
}
