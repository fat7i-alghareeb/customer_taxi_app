import 'package:customertaxi/common/imports/imports.dart';

import '../../../../domain/entities/order_saved_location_entity.dart';

class OrderLocationSuggestionsWidget extends StatelessWidget {
  const OrderLocationSuggestionsWidget({
    super.key,
    required this.state,
    required this.onSelected,
    required this.onPinToggled,
    this.isFillArea = false,
  });

  final BlocStatus<List<OrderSavedLocationEntity>> state;
  final ValueChanged<OrderSavedLocationEntity> onSelected;
  final ValueChanged<OrderSavedLocationEntity> onPinToggled;
  final bool isFillArea;

  @override
  Widget build(BuildContext context) {
    return StatusBuilder<List<OrderSavedLocationEntity>>(
      state: state,
      showInitWidget: false,
      showLoadingProgress: false,
      init: () => const SizedBox.shrink(),
      loading: () => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: REdgeInsets.only(top: AppSpacing.sm),
          child: LoadingDots(color: context.primary),
        ),
      ),
      isEmpty: (data) => data.isEmpty,
      empty: () => const SizedBox.shrink(),
      success: (data) {
        return ListView.separated(
          shrinkWrap: !isFillArea,
          physics: isFillArea
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          padding: REdgeInsets.only(bottom: AppSpacing.lg),
          itemCount: data.length,
          separatorBuilder: (context, index) => AppSpacing.sm.verticalSpace,
          itemBuilder: (context, index) {
            final location = data[index];
            final label = location.location.label;
            return Material(
                  color: context.surface,
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                    onLongPress: () {
                      printM(
                        '[OrderLocationSuggestionsWidget] suggestion long-press pin identity=${location.identityKey}',
                      );
                      onPinToggled(location);
                    },
                    onTap: () {
                      printM(
                        '[OrderLocationSuggestionsWidget] suggestion tapped label="$label"',
                      );
                      onSelected(location);
                    },
                    child: Container(
                      padding: REdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadii.lg.r),
                        border: Border.all(
                          color: context.colorScheme.outline.withValues(
                            alpha: 0.1,
                          ),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: REdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: context.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(
                                AppRadii.md.r,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.locationDot,
                              size: 14.r,
                              color: context.primary,
                            ),
                          ),
                          AppSpacing.md.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location.location.primaryName ?? label,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.s14w600.copyWith(
                                    color: context.onSurface,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                if ((location.location.secondaryAddress ?? '')
                                    .isNotEmpty) ...[
                                  AppSpacing.xs.verticalSpace,
                                  Text(
                                    location.location.secondaryAddress!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.s12w400.copyWith(
                                      color: context.onSurface.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          AppSpacing.sm.horizontalSpace,
                          Material(
                            color: location.isPinned
                                ? context.primary.withValues(alpha: 0.12)
                                : context.surface,
                            borderRadius: BorderRadius.circular(AppRadii.md.r),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                AppRadii.md.r,
                              ),
                              onTap: () {
                                printM(
                                  '[OrderLocationSuggestionsWidget] suggestion pin tapped identity=${location.identityKey}',
                                );
                                onPinToggled(location);
                              },
                              child: Padding(
                                padding: REdgeInsets.all(AppSpacing.sm),
                                child: FaIcon(
                                  FontAwesomeIcons.thumbtack,
                                  size: 13.r,
                                  color: location.isPinned
                                      ? context.primary
                                      : context.onSurface.withValues(
                                          alpha: 0.55,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .animate(delay: (index * 40).ms)
                .fadeIn(duration: 300.ms)
                .slideX(begin: 0.05, end: 0, curve: Curves.easeOutCubic);
          },
        );
      },
    );
  }
}
