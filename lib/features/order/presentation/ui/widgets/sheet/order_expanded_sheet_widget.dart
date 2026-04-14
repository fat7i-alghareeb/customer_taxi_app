import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../constants/forms/order_forms.dart';
import '../../../../constants/order_constants.dart';
import '../../../../domain/entities/order_location_entity.dart';
import '../../../states/order_bloc.dart';
import 'order_location_field_widget.dart';
import 'order_location_suggestions_widget.dart';
import 'order_map_context_trigger_widget.dart';

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
      return;
    }
    if (!_toFocusNode.hasFocus) {
      _setFocusedFieldTarget(null);
    }
  }

  void _handleToFocusChanged() {
    if (_toFocusNode.hasFocus) {
      _setFocusedFieldTarget(OrderLocationTarget.to);
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

    _isSyncing = true;
    control.updateValue(value, emitEvent: true);
    _isSyncing = false;
  }

  bool _consumeIgnoredQueryIfNeeded({
    required String field,
    required String query,
  }) {
    if (field == OrderForms.fromField && _ignoreNextFromQueryValue == query) {
      _ignoreNextFromQueryValue = null;
      return true;
    }
    if (field == OrderForms.toField && _ignoreNextToQueryValue == query) {
      _ignoreNextToQueryValue = null;
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
  }

  bool get _isConfirmActive {
    return widget.state.fromLocationState.isSuccess &&
        widget.state.toLocationState.isSuccess;
  }

  OrderLocationTarget get _resolvedMapTarget {
    return _focusedFieldTarget ?? OrderLocationTarget.to;
  }

  BlocStatus<List<OrderLocationEntity>> get _activeSuggestionsState {
    switch (_activeSearchTarget) {
      case OrderLocationTarget.from:
        return widget.state.fromSuggestionsState;
      case OrderLocationTarget.to:
        return widget.state.toSuggestionsState;
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

  void _onSharedSuggestionSelected(OrderLocationEntity location) {
    if (_activeSearchTarget == OrderLocationTarget.from) {
      _syncControlValue(OrderForms.fromField, location.label);
      context.read<OrderBloc>().add(
        OrderEvent.fromSuggestionSelected(location),
      );
      return;
    }
    _syncControlValue(OrderForms.toField, location.label);
    context.read<OrderBloc>().add(OrderEvent.toSuggestionSelected(location));
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
          final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
          final isKeyboardOpen = keyboardInset > 0;

          final headerSection = Container(
            height: OrderConstants.expandedHeaderHeight.h,
            padding: REdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: context.primary,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
            ),
            child: Row(
              children: [
                Container(
                  padding: REdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: context.onPrimary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadii.md.r),
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.route,
                    size: 18.r,
                    color: context.onPrimary,
                  ),
                ),
                AppSpacing.sm.horizontalSpace,
                Expanded(
                  child: Text(
                    AppStrings.planYourTrip,
                    style: AppTextStyles.s18w600.copyWith(
                      color: context.onPrimary,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w800,
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
                        size: 20.r,
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
                  if (_consumeIgnoredQueryIfNeeded(
                    field: OrderForms.fromField,
                    query: value,
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
                  if (_consumeIgnoredQueryIfNeeded(
                    field: OrderForms.toField,
                    query: value,
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
              context.read<OrderBloc>().add(
                const OrderEvent.confirmOrderPressed(),
              );
            },
            layout: AppButtonLayout(height: 54.sp, borderRadius: AppRadii.lg),
            child: AppButtonChild.label(AppStrings.confirmOrder),
          );

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
                        ? keyboardInset + AppSpacing.md
                        : AppSpacing.md,
                  ),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      fieldsSection
                          .animate()
                          .fadeIn(delay: 200.ms)
                          .slideY(
                            begin:
                                0.15, // Increased from 0.05 for more prominent effect
                            curve: Curves.easeOutCubic,
                          ),
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
                            color: context.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ).animate().fadeIn(delay: 450.ms).slideX(begin: -0.05),
                        AppSpacing.xxl.verticalSpace,
                      ],
                      OrderLocationSuggestionsWidget(
                        state: _activeSuggestionsState,
                        onSelected: _onSharedSuggestionSelected,
                      ).animate().fadeIn(delay: 550.ms),
                    ],
                  ),
                ),
              ),
              if (_isConfirmActive && !isKeyboardOpen)
                Padding(
                      padding: REdgeInsets.all(AppSpacing.md),
                      child: confirmButton,
                    )
                    .animate()
                    .fadeIn(delay: 650.ms)
                    .moveY(begin: 20, end: 0, curve: Curves.easeOutBack),
            ],
          );
        },
      ),
    );
  }
}
