import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/favorites/constants/forms/favorites_forms.dart';
import 'package:customertaxi/features/favorites/presentation/states/favorites_bloc.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_saved_location_entity.dart';
import 'package:customertaxi/features/order/presentation/ui/screens/location_picker_screen.dart';

class FavoritesScreen extends StatefulWidget {
  static const String pagePath = '/favorites';
  static const String pageName = 'FavoritesScreen';

  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final FormGroup _formGroup;

  @override
  void initState() {
    super.initState();
    _formGroup = FavoritesForms.formGroup();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<FavoritesBloc>()..add(const FavoritesEvent.started()),
      child: Builder(
        builder: (context) {
          return AppScaffold.all(
            appBarConfig: AppScaffoldAppBarConfig(
              title: AppStrings.favoritesTitle,
            ),
            searchConfig: AppScaffoldSearchConfig(
              formControlName: FavoritesForms.searchField,
              formGroup: _formGroup,
              hintText: AppStrings.favoritesSearchHint,
              onChangedDebounced: (value, isValid) {
                context.read<FavoritesBloc>().add(
                      FavoritesEvent.searchRequested(value),
                    );
              },
            ),
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                final isSearching =
                    _formGroup
                        .control(FavoritesForms.searchField)
                        .value
                        ?.toString()
                        .isNotEmpty ??
                    false;

                if (isSearching) {
                  return _SearchResultsSection(
                    state: state,
                    onSelected: (location) {
                      context.read<FavoritesBloc>().add(
                        FavoritesEvent.locationAdded(location),
                      );
                      _formGroup.control(FavoritesForms.searchField).value = '';
                      FocusScope.of(context).unfocus();
                    },
                  );
                }

                return _FavoritesListSection(
                  state: state,
                  onRemove: (identityKey) {
                    context.read<FavoritesBloc>().add(
                      FavoritesEvent.locationRemoved(identityKey),
                    );
                  },
                  onPinToggled: (location) {
                    context.read<FavoritesBloc>().add(
                      FavoritesEvent.pinToggled(location.location),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _FavoritesListSection extends StatelessWidget {
  const _FavoritesListSection({
    required this.state,
    required this.onRemove,
    required this.onPinToggled,
  });

  final FavoritesState state;
  final ValueChanged<String> onRemove;
  final ValueChanged<OrderSavedLocationEntity> onPinToggled;

  @override
  Widget build(BuildContext context) {
    return StatusBuilder<void>(
      state: state.loadStatus,
      loading: () => Center(
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.xxl),
          child: LoadingDots(color: context.primary),
        ),
      ),
      success: (_) {
        if (state.locations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmptyStateWidget(
                  text: AppStrings.favoritesEmpty,
                  icon: IconSource.icon(FontAwesomeIcons.locationDot),
                ),
                AppSpacing.lg.verticalSpace,
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: _SetOnMapCard(
                    onTap: () async {
                      final location = await context.pushNamed<OrderLocationEntity>(
                        LocationPickerScreen.pageName,
                      );
                      if (location != null && context.mounted) {
                        context
                            .read<FavoritesBloc>()
                            .add(FavoritesEvent.locationAdded(location));
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: REdgeInsets.all(AppSpacing.lg),
          itemCount: state.locations.length + 1,
          separatorBuilder: (context, index) => AppSpacing.md.verticalSpace,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _SetOnMapCard(
                onTap: () async {
                  final location = await context.pushNamed<OrderLocationEntity>(
                    LocationPickerScreen.pageName,
                  );
                  if (location != null && context.mounted) {
                    context
                        .read<FavoritesBloc>()
                        .add(FavoritesEvent.locationAdded(location));
                  }
                },
              );
            }
            final item = state.locations[index - 1];
            return _FavoriteItemCard(
              item: item,
              onRemove: () => onRemove(item.identityKey),
              onPinToggled: () => onPinToggled(item),
            );
          },
        );
      },
    );
  }
}

class _SearchResultsSection extends StatelessWidget {
  const _SearchResultsSection({required this.state, required this.onSelected});

  final FavoritesState state;
  final ValueChanged<OrderLocationEntity> onSelected;

  @override
  Widget build(BuildContext context) {
    return StatusBuilder<void>(
      state: state.searchStatus,
      loading: () => Center(
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.xxl),
          child: LoadingDots(color: context.primary),
        ),
      ),
      success: (_) {
        if (state.searchResults.isEmpty) {
          return EmptyStateWidget(
            text: AppStrings.noResultsFound,
            icon: IconSource.icon(FontAwesomeIcons.magnifyingGlass),
          );
        }

        return ListView.separated(
          padding: REdgeInsets.all(AppSpacing.lg),
          itemCount: state.searchResults.length + 1,
          separatorBuilder: (context, index) => AppSpacing.md.verticalSpace,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _SetOnMapCard(
                onTap: () async {
                  final location = await context.pushNamed<OrderLocationEntity>(
                    LocationPickerScreen.pageName,
                  );
                  if (location != null && context.mounted) {
                    context
                        .read<FavoritesBloc>()
                        .add(FavoritesEvent.locationAdded(location));
                  }
                },
              );
            }
            final location = state.searchResults[index - 1];
            return _SearchResultItemCard(
              location: location,
              onTap: () => onSelected(location),
            );
          },
        );
      },
    );
  }
}

class _FavoriteItemCard extends StatelessWidget {
  const _FavoriteItemCard({
    required this.item,
    required this.onRemove,
    required this.onPinToggled,
  });

  final OrderSavedLocationEntity item;
  final VoidCallback onRemove;
  final VoidCallback onPinToggled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        boxShadow: context.shadows.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          onTap: () {}, // Maybe navigate to map or set as destination
          child: Padding(
            padding: REdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  padding: REdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: context.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadii.md.r),
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.locationDot,
                    size: 18.r,
                    color: context.primary,
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.location.primaryName ?? item.location.label,
                        style: AppTextStyles.s16w600.copyWith(
                          color: context.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (item.location.secondaryAddress != null) ...[
                        AppSpacing.xs.verticalSpace,
                        Text(
                          item.location.secondaryAddress!,
                          style: AppTextStyles.s12w400.copyWith(
                            color: context.onSurface.withValues(alpha: 0.6),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: onPinToggled,
                      icon: FaIcon(
                        item.isPinned
                            ? FontAwesomeIcons.solidBookmark
                            : FontAwesomeIcons.bookmark,
                        size: 18.r,
                        color: item.isPinned
                            ? context.primary
                            : context.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                    IconButton(
                      onPressed: onRemove,
                      icon: FaIcon(
                        FontAwesomeIcons.trashCan,
                        size: 18.r,
                        color: AppColors.error.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _SearchResultItemCard extends StatelessWidget {
  const _SearchResultItemCard({required this.location, required this.onTap});

  final OrderLocationEntity location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        boxShadow: context.shadows.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          onTap: onTap,
          child: Padding(
            padding: REdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 16.r,
                  color: context.onSurface.withValues(alpha: 0.4),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.primaryName ?? location.label,
                        style: AppTextStyles.s16w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                      if (location.secondaryAddress != null) ...[
                        AppSpacing.xs.verticalSpace,
                        Text(
                          location.secondaryAddress!,
                          style: AppTextStyles.s12w400.copyWith(
                            color: context.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                AppSpacing.sm.horizontalSpace,
                FaIcon(
                  FontAwesomeIcons.plus,
                  size: 16.r,
                  color: context.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn();
  }
}

class _SetOnMapCard extends StatelessWidget {
  const _SetOnMapCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        boxShadow: context.shadows.primary,
        border: Border.all(
          color: context.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          onTap: onTap,
          child: Padding(
            padding: REdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  padding: REdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: context.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.mapLocationDot,
                    size: 16.r,
                    color: context.primary,
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Text(
                    AppStrings.setOnMap,
                    style: AppTextStyles.s16w600.copyWith(
                      color: context.primary,
                    ),
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: 14.r,
                  color: context.primary.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}
