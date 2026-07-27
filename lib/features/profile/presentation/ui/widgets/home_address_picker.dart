import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_request_entity.dart';
import 'package:customertaxi/features/order/domain/repositories/order_repository.dart';

import '../../../constants/forms/profile_forms.dart';

/// Home-address input offering all three ways to give an address, each one
/// visibly labelled.
///
/// The old version had a plain text field and an "open map" button, and nothing
/// told the rider that address search existed — typing never queried anything,
/// so people assumed the map button was the only way to find a real address.
/// Now the same field also drives suggestions, and a three-line legend names
/// each route explicitly: type it, search it, or pin it.
///
/// A pinned address (one with coordinates) is badged, because "Kerkstraat 12"
/// typed by hand and "Kerkstraat 12" resolved to a point are different things to
/// the driver, and the rider should be able to tell which one they have.
class HomeAddressPicker extends StatefulWidget {
  const HomeAddressPicker({
    required this.form,
    required this.isPinned,
    required this.onLabelTyped,
    required this.onLocationResolved,
    required this.onMapPressed,
    this.biasLat,
    this.biasLng,
    super.key,
  });

  final FormGroup form;

  /// Whether the current address carries coordinates.
  final bool isPinned;

  /// The rider typed a free-text address. Never fired for programmatic writes,
  /// so picking a suggestion doesn't immediately look like manual typing.
  final ValueChanged<String?> onLabelTyped;

  /// A suggestion was picked and resolved to a real point.
  final ValueChanged<OrderLocationEntity> onLocationResolved;

  final VoidCallback onMapPressed;

  /// Bias the search towards a known point, so "station" finds the local one.
  final double? biasLat;
  final double? biasLng;

  @override
  State<HomeAddressPicker> createState() => HomeAddressPickerState();
}

/// Public so the parent can hold a [GlobalKey] to it and push the map-picker
/// result in through [HomeAddressPickerState.applyPickedLabel].
class HomeAddressPickerState extends State<HomeAddressPicker> {
  bool _isSearching = false;
  bool _hasSearched = false;
  int _searchToken = 0;
  List<OrderLocationEntity> _results = const [];

  /// Writing the control programmatically re-fires the debounced change handler.
  /// Without this guard, choosing a suggestion would report back as manual
  /// typing one debounce later and drop the coordinates it just supplied.
  bool _suppressNextChange = false;

  FormControl<String> get _control =>
      widget.form.control(ProfileForms.homeAddressField) as FormControl<String>;

  void _writeLabel(String label) {
    _suppressNextChange = true;
    _control.updateValue(label);
  }

  void _onChanged(String value) {
    if (_suppressNextChange) {
      _suppressNextChange = false;
      return;
    }
    final trimmed = value.trim();
    widget.onLabelTyped(trimmed.isEmpty ? null : trimmed);
    unawaited(_search(trimmed));
  }

  Future<void> _search(String query) async {
    // Token guard: an earlier, slower response must not overwrite a later one.
    final token = ++_searchToken;

    if (query.length < 2) {
      if (mounted) {
        setState(() {
          _isSearching = false;
          _hasSearched = false;
          _results = const [];
        });
      }
      return;
    }

    setState(() {
      _isSearching = true;
      _hasSearched = true;
    });

    final result = await getIt<OrderRepository>().searchLocations(
      OrderLocationSearchRequestEntity(
        query: query,
        biasLat: widget.biasLat,
        biasLng: widget.biasLng,
      ),
    );

    if (!mounted || token != _searchToken) return;

    result.when(
      success: (locations) => setState(() {
        _isSearching = false;
        _results = locations;
      }),
      failure: (message) {
        setState(() {
          _isSearching = false;
          _results = const [];
        });
        showErrorOverlay(context, message);
      },
    );
  }

  void _selectSuggestion(OrderLocationEntity location) {
    _writeLabel(location.label);
    setState(() {
      _results = const [];
      _hasSearched = false;
      _isSearching = false;
      // Drop any in-flight response so it cannot re-open the panel.
      _searchToken++;
    });
    widget.onLocationResolved(location);
    FocusScope.of(context).unfocus();
  }

  /// Called by the parent after the map picker returns, so the programmatic
  /// write doesn't read back as typing.
  void applyPickedLabel(String label) => _writeLabel(label);

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final showPanel = _hasSearched && (_isSearching || _results.isNotEmpty);
    final showEmpty = _hasSearched && !_isSearching && _results.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppReactiveTextField.text(
          formControlName: ProfileForms.homeAddressField,
          title: AppStrings.profileHomeAddress,
          hintText: AppStrings.profileHomeAddressHint,
          onChangedDebounced: (value, _) => _onChanged(value),
          prefix: Icon(
            Icons.search,
            size: 20.r,
            color: colors.primary,
          ),
        ),

        if (showPanel) ...[
          AppSpacing.sm.verticalSpace,
          _SuggestionPanel(
            isSearching: _isSearching,
            results: _results,
            onSelected: _selectSuggestion,
          ),
        ] else if (showEmpty) ...[
          AppSpacing.sm.verticalSpace,
          _Hint(
            icon: FontAwesomeIcons.circleInfo,
            text: AppStrings.addressNoResults,
          ),
        ],

        AppSpacing.md.verticalSpace,

        // The legend is the whole point of this widget: it names each of the
        // three ways in, so nobody has to guess what the field or button do.
        _Hint(
          icon: FontAwesomeIcons.keyboard,
          text: AppStrings.addressModeTypeHint,
        ),
        AppSpacing.xs.verticalSpace,
        _Hint(
          icon: FontAwesomeIcons.magnifyingGlass,
          text: AppStrings.addressModeSearchHint,
        ),
        AppSpacing.xs.verticalSpace,
        _Hint(
          icon: FontAwesomeIcons.mapLocationDot,
          text: AppStrings.addressModeMapHint,
        ),

        if (widget.isPinned) ...[
          AppSpacing.sm.verticalSpace,
          const _PinnedBadge(),
        ],

        AppSpacing.sm.verticalSpace,
        AppButton.outline(
          layout: AppButtonLayout(
            width: double.infinity,
            height: 48.h,
            borderRadius: AppRadii.lg,
          ),
          onTap: widget.onMapPressed,
          child: AppButtonChild.labelIcon(
            label: AppStrings.setOnMap,
            icon: IconSource.faIcon(
              widget.isPinned
                  ? FontAwesomeIcons.locationCrosshairs
                  : FontAwesomeIcons.mapLocationDot,
            ),
          ),
        ),
      ],
    );
  }
}

/// Dropdown of address suggestions, styled as a raised card so it reads as a
/// transient overlay on the form rather than another permanent field.
class _SuggestionPanel extends StatelessWidget {
  const _SuggestionPanel({
    required this.isSearching,
    required this.results,
    required this.onSelected,
  });

  final bool isSearching;
  final List<OrderLocationEntity> results;
  final ValueChanged<OrderLocationEntity> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Container(
      constraints: BoxConstraints(maxHeight: 260.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: colors.onSurface.withValues(alpha: 0.08),
          width: 1.r,
        ),
      ),
      child: isSearching
          ? Padding(
              padding: REdgeInsets.all(AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingDots(color: colors.primary),
                  AppSpacing.md.horizontalSpace,
                  Text(
                    AppStrings.addressSearchingLabel,
                    style: AppTextStyles.s12w400.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
              itemCount: results.length,
              separatorBuilder: (_, _) => Divider(
                height: 1,
                color: colors.onSurface.withValues(alpha: 0.08),
              ),
              itemBuilder: (context, index) {
                final location = results[index];
                final secondary = location.secondaryAddress;
                return ListTile(
                  dense: true,
                  leading: FaIcon(
                    FontAwesomeIcons.locationDot,
                    size: 16.r,
                    color: colors.primary,
                  ),
                  title: Text(
                    location.primaryName ?? location.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s14w600.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                  subtitle: secondary != null && secondary.isNotEmpty
                      ? Text(
                          secondary,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s12w400.copyWith(
                            color: colors.onSurface.withValues(alpha: 0.6),
                          ),
                        )
                      : null,
                  onTap: () => onSelected(location),
                );
              },
            ),
    );
  }
}

/// One line of the three-mode legend.
class _Hint extends StatelessWidget {
  const _Hint({required this.icon, required this.text});

  final FaIconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.only(top: 2),
          child: FaIcon(
            icon,
            size: 12.r,
            color: colors.primary.withValues(alpha: 0.7),
          ),
        ),
        AppSpacing.sm.horizontalSpace,
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.s12w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

/// Shown once the address has real coordinates behind it.
class _PinnedBadge extends StatelessWidget {
  const _PinnedBadge();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadii.xl.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.locationCrosshairs,
              size: 11.r,
              color: AppColors.success,
            ),
            AppSpacing.sm.horizontalSpace,
            Text(
              AppStrings.addressPinnedBadge,
              style: AppTextStyles.s12w400.copyWith(color: AppColors.success),
            ),
          ],
        ),
      ),
    );
  }
}
