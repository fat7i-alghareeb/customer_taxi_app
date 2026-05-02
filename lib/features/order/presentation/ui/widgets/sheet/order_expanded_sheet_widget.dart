import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../constants/forms/order_forms.dart';
import '../../../../constants/order_constants.dart';
import '../../../../domain/entities/order_location_entity.dart';
import '../../../../domain/entities/order_saved_location_entity.dart';
import '../../../states/order_bloc.dart';
import 'order_location_field_widget.dart';
import 'order_location_suggestions_widget.dart';
import 'order_booking_details_step_widget.dart';
import 'order_map_context_trigger_widget.dart';
import 'order_pickup_point_step_widget.dart';
import 'order_vehicle_selection_step_widget.dart';

class OrderExpandedSheetWidget extends StatefulWidget {
  const OrderExpandedSheetWidget({super.key, required this.state});

  final OrderState state;

  @override
  State<OrderExpandedSheetWidget> createState() =>
      _OrderExpandedSheetWidgetState();
}

class _OrderExpandedSheetWidgetState extends State<OrderExpandedSheetWidget> {
  late final FormGroup _form;
  late final FocusNode _fromFocusNode;
  late final FocusNode _toFocusNode;

  bool _isSyncing = false;
  OrderLocationTarget _activeSearchTarget = OrderLocationTarget.to;
  OrderLocationTarget? _focusedFieldTarget;

  String? _ignoreNextFromQueryValue;
  String? _ignoreNextToQueryValue;
  String? _ignoreNextPickupStreetValue;
  String? _ignoreNextPickupHouseNumberValue;

  @override
  void initState() {
    super.initState();
    _fromFocusNode = FocusNode();
    _toFocusNode = FocusNode();

    _fromFocusNode.addListener(_handleFromFocusChanged);
    _toFocusNode.addListener(_handleToFocusChanged);

    _form = OrderForms.formGroup();
    _syncFormWithState(widget.state);
  }

  @override
  void dispose() {
    _fromFocusNode.removeListener(_handleFromFocusChanged);
    _toFocusNode.removeListener(_handleToFocusChanged);
    _fromFocusNode.dispose();
    _toFocusNode.dispose();
    super.dispose();
  }

  void _handleFromFocusChanged() {
    if (_fromFocusNode.hasFocus) {
      _setFocusedFieldTarget(OrderLocationTarget.from);
      _setActiveSearchTarget(OrderLocationTarget.from);
      final value = _form.control(OrderForms.fromField).value?.toString() ?? '';
      if (value.trim().isEmpty) {
        context.read<OrderBloc>().add(const OrderEvent.fromQueryChanged(''));
      }
      return;
    }
    if (!_toFocusNode.hasFocus) {
      _setFocusedFieldTarget(null);
    }
  }

  void _handleToFocusChanged() {
    if (_toFocusNode.hasFocus) {
      _setFocusedFieldTarget(OrderLocationTarget.to);
      _setActiveSearchTarget(OrderLocationTarget.to);
      final value = _form.control(OrderForms.toField).value?.toString() ?? '';
      if (value.trim().isEmpty) {
        context.read<OrderBloc>().add(const OrderEvent.toQueryChanged(''));
      }
      return;
    }
    if (!_fromFocusNode.hasFocus) {
      _setFocusedFieldTarget(null);
    }
  }

  void _setFocusedFieldTarget(OrderLocationTarget? target) {
    if (_focusedFieldTarget == target || !mounted) {
      return;
    }
    setState(() {
      _focusedFieldTarget = target;
      if (target != null) {
        _activeSearchTarget = target;
      }
    });
  }

  @override
  void didUpdateWidget(covariant OrderExpandedSheetWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      _syncFormWithState(widget.state);

      final wasConfirmActive =
          oldWidget.state.fromLocationState.isSuccess &&
          oldWidget.state.toLocationState.isSuccess;
      final isConfirmActiveNow =
          widget.state.fromLocationState.isSuccess &&
          widget.state.toLocationState.isSuccess;

      if (!wasConfirmActive && isConfirmActiveNow) {
        FocusScope.of(context).unfocus();
      }
    }
  }

  String? _extractLabel(BlocStatus<OrderLocationEntity> status) {
    String? result;
    status.when(
      initial: () {},
      loading: () {},
      success: (location) {
        result = location.label;
      },
      failure: (_) {},
    );
    return result;
  }

  void _syncControlValue(String field, String value) {
    final control = _form.control(field);
    if (control.value?.toString() == value) {
      return;
    }
    if (field == OrderForms.fromField) {
      _ignoreNextFromQueryValue = value;
    }
    if (field == OrderForms.toField) {
      _ignoreNextToQueryValue = value;
    }
    if (field == OrderForms.pickupStreetField) {
      _ignoreNextPickupStreetValue = value;
    }
    if (field == OrderForms.pickupHouseNumberField) {
      _ignoreNextPickupHouseNumberValue = value;
    }

    _isSyncing = true;
    control.updateValue(value, emitEvent: true);
    _isSyncing = false;
  }

  bool _consumeIgnoredValueIfNeeded({
    required String field,
    required String value,
  }) {
    if (field == OrderForms.fromField && _ignoreNextFromQueryValue == value) {
      _ignoreNextFromQueryValue = null;
      return true;
    }
    if (field == OrderForms.toField && _ignoreNextToQueryValue == value) {
      _ignoreNextToQueryValue = null;
      return true;
    }
    if (field == OrderForms.pickupStreetField &&
        _ignoreNextPickupStreetValue == value) {
      _ignoreNextPickupStreetValue = null;
      return true;
    }
    if (field == OrderForms.pickupHouseNumberField &&
        _ignoreNextPickupHouseNumberValue == value) {
      _ignoreNextPickupHouseNumberValue = null;
      return true;
    }
    return false;
  }

  void _syncFormWithState(OrderState state) {
    final fromLabel = _extractLabel(state.fromLocationState);
    final toLabel = _extractLabel(state.toLocationState);

    if (fromLabel != null && fromLabel.trim().isNotEmpty) {
      _syncControlValue(OrderForms.fromField, fromLabel);
    }
    if (toLabel != null && toLabel.trim().isNotEmpty) {
      _syncControlValue(OrderForms.toField, toLabel);
    }

    _syncControlValue(OrderForms.pickupStreetField, state.pickupStreetName);
    _syncControlValue(
      OrderForms.pickupHouseNumberField,
      state.pickupHouseNumber,
    );
  }

  bool get _isConfirmActive {
    return widget.state.fromLocationState.isSuccess &&
        widget.state.toLocationState.isSuccess;
  }

  bool get _isVehicleSelectionStep {
    return widget.state.expandedStep == OrderExpandedStep.carSelection;
  }

  bool get _isPickupPointStep {
    return widget.state.expandedStep == OrderExpandedStep.pickupPoint;
  }

  bool get _isBookingDetailsStep {
    return widget.state.expandedStep == OrderExpandedStep.bookingDetails;
  }

  bool get _isVehicleConfirmActive {
    return widget.state.selectedCarTypeId?.trim().isNotEmpty ?? false;
  }

  bool get _isPickupConfirmActive {
    return widget.state.pickupPointState.isSuccess;
  }

  OrderLocationTarget get _resolvedMapTarget {
    return _focusedFieldTarget ?? OrderLocationTarget.to;
  }

  BlocStatus<List<OrderSavedLocationEntity>> get _activeSuggestionsState {
    switch (_activeSearchTarget) {
      case OrderLocationTarget.from:
        return widget.state.fromSuggestionsState;
      case OrderLocationTarget.to:
        return widget.state.toSuggestionsState;
      case OrderLocationTarget.pickupPoint:
        return const BlocStatus<List<OrderSavedLocationEntity>>.initial();
    }
  }

  void _setActiveSearchTarget(OrderLocationTarget target) {
    if (_activeSearchTarget == target) {
      return;
    }
    setState(() {
      _activeSearchTarget = target;
    });
  }

  void _onSharedSuggestionSelected(OrderSavedLocationEntity location) {
    if (_activeSearchTarget == OrderLocationTarget.from) {
      _syncControlValue(OrderForms.fromField, location.location.label);
      context.read<OrderBloc>().add(
        OrderEvent.fromSuggestionSelected(location),
      );
      return;
    }
    _syncControlValue(OrderForms.toField, location.location.label);
    context.read<OrderBloc>().add(OrderEvent.toSuggestionSelected(location));
  }

  void _onSharedSuggestionPinToggled(OrderSavedLocationEntity location) {
    if (_activeSearchTarget == OrderLocationTarget.pickupPoint) {
      return;
    }

    context.read<OrderBloc>().add(
      OrderEvent.savedLocationPinToggled(
        target: _activeSearchTarget,
        location: location,
      ),
    );
  }

  void _clearField(OrderLocationTarget target) {
    final isFrom = target == OrderLocationTarget.from;
    final field = isFrom ? OrderForms.fromField : OrderForms.toField;

    if (isFrom) {
      _ignoreNextFromQueryValue = '';
    } else {
      _ignoreNextToQueryValue = '';
    }

    _isSyncing = true;
    _form.control(field).updateValue('', emitEvent: true);
    _isSyncing = false;

    _setActiveSearchTarget(target);
    if (isFrom) {
      _fromFocusNode.requestFocus();
      context.read<OrderBloc>().add(const OrderEvent.fromLocationCleared());
      return;
    }

    _toFocusNode.requestFocus();
    context.read<OrderBloc>().add(const OrderEvent.toLocationCleared());
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isKeyboardOpen = context.bottomInset > 0;

          final headerSection = Container(
            height: OrderConstants.expandedHeaderHeight.sp,
            padding: REdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: context.primary,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
            ),
            child: Row(
              children: [
                Material(
                  color: context.onPrimary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                    onTap: () {
                      if (_isBookingDetailsStep) {
                        context.read<OrderBloc>().add(
                          const OrderEvent.bookingDetailsBackPressed(),
                        );
                        return;
                      }

                      if (_isPickupPointStep) {
                        context.read<OrderBloc>().add(
                          const OrderEvent.pickupPointBackPressed(),
                        );
                        return;
                      }

                      if (_isVehicleSelectionStep) {
                        context.read<OrderBloc>().add(
                          const OrderEvent.vehicleStepBackPressed(),
                        );
                        return;
                      }

                      context.read<OrderBloc>().add(
                        const OrderEvent.collapseRequested(),
                      );
                    },
                    child: Padding(
                      padding: REdgeInsets.all(AppSpacing.sm),
                      child: FaIcon(
                        context.chevronStart,
                        size: 16.r,
                        color: context.onPrimary,
                      ),
                    ),
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Text(
                    _isBookingDetailsStep
                        ? AppStrings.bookingDetails
                        : _isVehicleSelectionStep
                        ? AppStrings.selectCarType
                        : _isPickupPointStep
                        ? AppStrings.selectPickupPoint
                        : AppStrings.planYourTrip,
                    style: AppTextStyles.s16w600.copyWith(
                      color: context.onPrimary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Material(
                  color: context.onPrimary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                    onTap: () {
                      context.read<OrderBloc>().add(
                        const OrderEvent.collapseRequested(),
                      );
                    },
                    child: Padding(
                      padding: REdgeInsets.all(AppSpacing.sm),
                      child: FaIcon(
                        FontAwesomeIcons.xmark,
                        size: 18.r,
                        color: context.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

          final fieldsSection = Column(
            children: [
              OrderLocationFieldWidget(
                formControlName: OrderForms.fromField,
                title: AppStrings.from,
                hintText: AppStrings.searchFromLocation,
                iconData: FontAwesomeIcons.locationArrow,
                focusNode: _fromFocusNode,
                onClearPressed: () {
                  _clearField(OrderLocationTarget.from);
                },
                onQueryChanged: (value) {
                  if (_isSyncing) return;
                  if (_consumeIgnoredValueIfNeeded(
                    field: OrderForms.fromField,
                    value: value,
                  )) {
                    return;
                  }
                  _setActiveSearchTarget(OrderLocationTarget.from);
                  context.read<OrderBloc>().add(
                    OrderEvent.fromQueryChanged(value),
                  );
                },
              ),
              AppSpacing.md.verticalSpace,
              OrderLocationFieldWidget(
                formControlName: OrderForms.toField,
                title: AppStrings.to,
                hintText: AppStrings.searchToLocation,
                iconData: FontAwesomeIcons.locationDot,
                focusNode: _toFocusNode,
                onClearPressed: () {
                  _clearField(OrderLocationTarget.to);
                },
                onQueryChanged: (value) {
                  if (_isSyncing) return;
                  if (_consumeIgnoredValueIfNeeded(
                    field: OrderForms.toField,
                    value: value,
                  )) {
                    return;
                  }
                  _setActiveSearchTarget(OrderLocationTarget.to);
                  context.read<OrderBloc>().add(
                    OrderEvent.toQueryChanged(value),
                  );
                },
              ),
            ],
          );

          final mapTrigger = OrderMapContextTriggerWidget(
            target: _resolvedMapTarget,
            onTap: () {
              FocusScope.of(context).unfocus();
              context.read<OrderBloc>().add(
                OrderEvent.setOnMapPressed(_resolvedMapTarget),
              );
            },
          );

          final confirmButton = AppButton.primary(
            onTap: () {
              FocusScope.of(context).unfocus();
              context.read<OrderBloc>().add(
                const OrderEvent.confirmOrderPressed(),
              );
            },
            layout: AppButtonLayout(
              width: double.infinity,
              height: 54.sp,
              borderRadius: AppRadii.lg,
            ),
            child: AppButtonChild.label(AppStrings.confirmLocations),
          );

          final vehicleConfirmButton = AppButton.primary(
            onTap: () {
              context.read<OrderBloc>().add(
                const OrderEvent.confirmCarSelectionPressed(),
              );
            },
            layout: AppButtonLayout(
              width: double.infinity,
              height: 54.sp,
              borderRadius: AppRadii.lg,
            ),
            child: AppButtonChild.label(AppStrings.done),
          );

          final pickupConfirmButton = AppButton.primary(
            onTap: () {
              FocusScope.of(context).unfocus();
              context.read<OrderBloc>().add(
                const OrderEvent.confirmPickupPointPressed(),
              );
            },
            isActive: _isPickupConfirmActive,
            layout: AppButtonLayout(
              width: double.infinity,
              height: 54.sp,
              borderRadius: AppRadii.lg,
            ),
            child: AppButtonChild.label(AppStrings.confirmOrder),
          );

          if (_isVehicleSelectionStep) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: OrderVehicleSelectionStepWidget(
                      state: widget.state,
                      onCarTypeTapped: (typeId) {
                        context.read<OrderBloc>().add(
                          OrderEvent.carTypeToggled(typeId),
                        );
                      },
                    ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.08),
                  ),
                  if (_isVehicleConfirmActive && !isKeyboardOpen)
                    Padding(
                          padding: REdgeInsets.only(bottom: AppSpacing.lg),
                          child: vehicleConfirmButton,
                        )
                        .animate()
                        .fadeIn(duration: AppDurations.fast)
                        .moveY(
                          begin: 16,
                          end: 0,
                          duration: AppDurations.slow,
                          curve: Curves.easeOutCubic,
                        ),
                ],
              ),
            );
          }

          if (_isPickupPointStep) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: OrderPickupPointStepWidget(
                      state: widget.state,
                      onSetPickupOnMapPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<OrderBloc>().add(
                          const OrderEvent.setOnMapPressed(
                            OrderLocationTarget.pickupPoint,
                          ),
                        );
                      },
                      onPickupStreetChanged: (value) {
                        if (_isSyncing) {
                          return;
                        }

                        if (_consumeIgnoredValueIfNeeded(
                          field: OrderForms.pickupStreetField,
                          value: value,
                        )) {
                          return;
                        }

                        context.read<OrderBloc>().add(
                          OrderEvent.pickupStreetChanged(value),
                        );
                      },
                      onPickupHouseNumberChanged: (value) {
                        if (_isSyncing) {
                          return;
                        }

                        if (_consumeIgnoredValueIfNeeded(
                          field: OrderForms.pickupHouseNumberField,
                          value: value,
                        )) {
                          return;
                        }

                        context.read<OrderBloc>().add(
                          OrderEvent.pickupHouseNumberChanged(value),
                        );
                      },
                    ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.08),
                  ),
                  if (!isKeyboardOpen)
                    Padding(
                          padding: REdgeInsets.only(bottom: AppSpacing.lg),
                          child: pickupConfirmButton,
                        )
                        .animate()
                        .fadeIn(duration: AppDurations.fast)
                        .moveY(
                          begin: 16,
                          end: 0,
                          duration: AppDurations.slow,
                          curve: Curves.easeOutCubic,
                        ),
                ],
              ),
            );
          }

          if (_isBookingDetailsStep) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: SizedBox(
                      height: 420.h,
                      child: OrderBookingDetailsStepWidget(state: widget.state),
                    ),
                  ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.08),
                ],
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final showInlineConfirm =
                  _isConfirmActive &&
                  !isKeyboardOpen &&
                  constraints.maxHeight <= 220.h;

              return Column(
                children: [
                  AppSpacing.xl.verticalSpace,
                  headerSection
                      .animate()
                      .fadeIn(delay: 50.ms)
                      .slideY(begin: -0.1, curve: Curves.easeOutQuart),
                  AppSpacing.lg.verticalSpace,
                  Expanded(
                    child: SingleChildScrollView(
                      padding: REdgeInsets.only(
                        left: AppSpacing.md,
                        right: AppSpacing.md,
                        top: AppSpacing.md,
                        bottom: isKeyboardOpen
                            ? context.bottomInset + AppSpacing.md
                            : AppSpacing.sm,
                      ),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          fieldsSection
                              .animate()
                              .fadeIn(delay: 200.ms)
                              .slideY(begin: 0.15, curve: Curves.easeOutCubic),
                          AppSpacing.xl.verticalSpace,
                          mapTrigger
                              .animate()
                              .fadeIn(delay: 350.ms)
                              .slideY(begin: 0.1, curve: Curves.easeOutCubic),
                          AppSpacing.xl.verticalSpace,
                          if (_activeSuggestionsState.maybeWhen(
                            success: (items) => items.isNotEmpty,
                            orElse: () => false,
                          )) ...[
                            Text(
                                  AppStrings.suggestions,
                                  style: AppTextStyles.s12w400.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                                .animate()
                                .fadeIn(delay: 450.ms)
                                .slideX(begin: -0.05),
                            AppSpacing.xxl.verticalSpace,
                          ],
                          OrderLocationSuggestionsWidget(
                            state: _activeSuggestionsState,
                            onSelected: _onSharedSuggestionSelected,
                            onPinToggled: _onSharedSuggestionPinToggled,
                          ).animate().fadeIn(delay: 550.ms),
                          if (showInlineConfirm) ...[
                            AppSpacing.md.verticalSpace,
                            confirmButton,
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (_isConfirmActive && !isKeyboardOpen && !showInlineConfirm)
                    Padding(
                          padding: REdgeInsets.only(bottom: AppSpacing.lg),
                          child: confirmButton,
                        )
                        .animate()
                        .fadeIn(delay: 100.ms)
                        .moveY(begin: 20, end: 0, curve: Curves.easeOutBack),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
