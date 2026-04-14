import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';

import '../../../../domain/entities/order_location_entity.dart';

class OrderLocationSuggestionsWidget extends StatelessWidget {
  const OrderLocationSuggestionsWidget({
    super.key,
    required this.state,
    required this.onSelected,
    this.isFillArea = false,
  });

  final BlocStatus<List<OrderLocationEntity>> state;
  final ValueChanged<OrderLocationEntity> onSelected;
  final bool isFillArea;

  @override
  Widget build(BuildContext context) {
    return StatusBuilder<List<OrderLocationEntity>>(
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
            return Material(
              color: context.surface,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadii.lg.r),
                onTap: () {
                  printM(
                    '[OrderLocationSuggestionsWidget] suggestion tapped label="${location.label}"',
                  );
                  onSelected(location);
                },
                child: Container(
                  padding: REdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                    border: Border.all(
                      color: context.colorScheme.outline.withValues(alpha: 0.1),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: REdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: context.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(AppRadii.md.r),
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
                              location.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.s14w600.copyWith(
                                color: context.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (location.label.contains(',')) ...[
                              AppSpacing.xs.verticalSpace,
                              Text(
                                location.label.split(',').skip(1).join(',').trim(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.s12w400.copyWith(
                                  color: context.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate(delay: (index * 40).ms).fadeIn(duration: 300.ms).slideX(
                  begin: 0.05,
                  end: 0,
                  curve: Curves.easeOutCubic,
                );
          },
        );
      },
    );
  }
}

