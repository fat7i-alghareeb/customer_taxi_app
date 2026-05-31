import 'package:customertaxi/common/imports/imports.dart';

import '../../../../constants/forms/order_forms.dart';
import '../../../../constants/order_constants.dart';
import '../../../../domain/entities/order_saved_location_entity.dart';
import '../../../states/order_bloc.dart';
import 'order_location_field_widget.dart';
import 'order_location_suggestions_widget.dart';
import 'order_booking_details_step_widget.dart';
import 'order_map_context_trigger_widget.dart';
import 'order_schedule_picker_widget.dart';
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
  final List<FocusNode> _focusNodes = [];

  bool _isSyncing = false;
  int _activeSearchIndex = 1;
  int? _focusedFieldIndex;

  @override
  void initState() {
    super.initState();
    _form = OrderForms.formGroup();
    _updateFocusNodes(widget.state.stops.list.length);
    _syncFormWithState(widget.state);
  }

  void _updateFocusNodes(int count) {
    while (_focusNodes.length < count) {
      final node = FocusNode();
      final index = _focusNodes.length;
      node.addListener(() => _handleFocusChanged(index));
      _focusNodes.add(node);
    }
    while (_focusNodes.length > count) {
      _focusNodes.removeLast().dispose();
    }
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant OrderExpandedSheetWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      printM('[OrderExpandedSheetWidget] didUpdateWidget state changed');
      _syncFormWithState(widget.state);
    }

    if (widget.state.stops.list.isEmpty) {
      _activeSearchIndex = 0;
      _focusedFieldIndex = null;
      return;
    }

    if (_activeSearchIndex >= widget.state.stops.list.length) {
      _activeSearchIndex = widget.state.stops.list.length - 1;
    }

    if (_focusedFieldIndex != null &&
        _focusedFieldIndex! >= widget.state.stops.list.length) {
      _focusedFieldIndex = null;
    }
  }

  void _handleFocusChanged(int index) {
    if (_focusNodes[index].hasFocus) {
      printM('[OrderExpandedSheetWidget] field $index gained focus');
      setState(() {
        _focusedFieldIndex = index;
        _activeSearchIndex = index;
      });
      context.read<OrderBloc>().add(OrderEvent.activeStopChanged(index));
      
      final array = _form.control(OrderForms.stopsArray) as FormArray<String>;
      final control = array.controls[index] as FormControl<String>;
      final value = control.value ?? '';
      
      printM('[OrderExpandedSheetWidget] field $index focus check: value="$value"');
      
      if (value.trim().isEmpty) {
        printM('[OrderExpandedSheetWidget] field $index empty, sending stopQueryChanged("")');
        context.read<OrderBloc>().add(OrderEvent.stopQueryChanged(index, ''));
      }
    } else {
      printM('[OrderExpandedSheetWidget] field $index lost focus');
      if (_focusNodes.every((n) => !n.hasFocus)) {
        setState(() => _focusedFieldIndex = null);
      }
    }
  }

  void _syncFormWithState(OrderState state) {
    if (_isSyncing) {
      printY('[OrderExpandedSheetWidget] _syncFormWithState blocked (already syncing)');
      return;
    }
    printM('[OrderExpandedSheetWidget] _syncFormWithState start');
    _isSyncing = true;

    final array = _form.control(OrderForms.stopsArray) as FormArray<String>;
    final stopsList = state.stops.list;
    final queries = state.stops.queries;

    // Adjust FormArray length
    if (array.controls.length != stopsList.length) {
      printM('[OrderExpandedSheetWidget] adjusting array length from ${array.controls.length} to ${stopsList.length}');
      while (array.controls.length < stopsList.length) {
        array.add(FormControl<String>(validators: [Validators.required]));
      }
      while (array.controls.length > stopsList.length) {
        array.removeAt(array.controls.length - 1);
      }
    }

    _updateFocusNodes(stopsList.length);

    for (var i = 0; i < stopsList.length; i++) {
      // Keep field text in sync with stop queries to preserve user input.
      final query = i < queries.length
          ? queries[i]
          : (stopsList[i]?.label ?? '');
      final control = array.controls[i] as FormControl<String>;
      
      if ((control.value ?? '') != query) {
        printG('[OrderExpandedSheetWidget] index=$i query sync: control="${control.value}" -> new="$query"');
        // We use emitEvent: true to ensure the UI (ReactiveTextField) picks up the programmatic change.
        // The _isSyncing guard in onQueryChanged prevents infinite loops.
        control.updateValue(query, emitEvent: true);
      } else {
        printGray('[OrderExpandedSheetWidget] index=$i query already in sync: "$query"');
      }
    }

    _isSyncing = false;
    printM('[OrderExpandedSheetWidget] _syncFormWithState completed');
  }

  bool get _isConfirmActive {
    final allStopsResolved = widget.state.stops.list.every((s) => s != null);
    if (!allStopsResolved) return false;
    if (widget.state.booking.scheduleMode == OrderScheduleMode.later) {
      if (widget.state.booking.scheduledAt == null) return false;
      final minTime = DateTime.now().add(const Duration(minutes: 15));
      if (widget.state.booking.scheduledAt!.isBefore(minTime)) {
        return false;
      }
    }
    return true;
  }

  bool get _isVehicleSelectionStep =>
      widget.state.sheet.expandedStep == OrderExpandedStep.carSelection;
  bool get _isBookingDetailsStep =>
      widget.state.sheet.expandedStep == OrderExpandedStep.bookingDetails;

  bool get _isVehicleConfirmActive =>
      widget.state.trip.selectedCarTypeId?.trim().isNotEmpty ?? false;

  BlocStatus<List<OrderSavedLocationEntity>> get _activeSuggestionsState {
    final suggestions = widget.state.stops.suggestionsState;
    if (_activeSearchIndex < 0 || _activeSearchIndex >= suggestions.length) {
      return const BlocStatus.initial();
    }
    return suggestions[_activeSearchIndex];
  }

  void _onSharedSuggestionSelected(OrderSavedLocationEntity location) {
    context.read<OrderBloc>().add(
      OrderEvent.stopSuggestionSelected(_activeSearchIndex, location),
    );
  }

  void _onSharedSuggestionPinToggled(OrderSavedLocationEntity location) {
    context.read<OrderBloc>().add(
      OrderEvent.savedLocationPinToggled(
        stopIndex: _activeSearchIndex,
        location: location,
      ),
    );
  }

  void _clearField(int index) {
    context.read<OrderBloc>().add(OrderEvent.stopCleared(index));
  }

  @override
  Widget build(BuildContext context) {
    printM('[OrderExpandedSheetWidget] build start');
    return ReactiveForm(
      formGroup: _form,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isKeyboardOpen = context.bottomInset > 0;
          printM('[OrderExpandedSheetWidget] LayoutBuilder isKeyboardOpen=$isKeyboardOpen');

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
                        color: context.onSurface,
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
                        : AppStrings.planYourTrip,
                    style: AppTextStyles.s16w600.copyWith(
                      color: context.onSurface,
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
                        color: context.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

          final fieldsSection = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.state.stops.list.length,
                onReorder: (oldIndex, newIndex) {
                  printM('[OrderExpandedSheetWidget] onReorder old=$oldIndex new=$newIndex');
                  if (newIndex > oldIndex) newIndex -= 1;
                  context.read<OrderBloc>().add(OrderEvent.stopReordered(oldIndex, newIndex));
                },
                itemBuilder: (context, index) {
                  printM('[OrderExpandedSheetWidget] itemBuilder index=$index');
                  final isFirst = index == 0;
                  final stopsLen = widget.state.stops.list.length;
                  final isLast = index == stopsLen - 1;
                  final title = isFirst ? AppStrings.from : (isLast ? AppStrings.to : AppStrings.stop);
                  
                  return Padding(
                    key: ValueKey('stop_$index'),
                    padding: REdgeInsets.only(bottom: AppSpacing.md),
                    child: OrderLocationFieldWidget(
                      formControlName: '${OrderForms.stopsArray}.$index',
                      title: title,
                      hintText: isFirst ? AppStrings.searchFromLocation : AppStrings.searchToLocation,
                      iconData: isFirst ? FontAwesomeIcons.circleDot : FontAwesomeIcons.locationDot,
                      focusNode: _focusNodes[index],
                      onClearPressed: () => _clearField(index),
                      onAddPressed: isLast && stopsLen < 5
                          ? () => context.read<OrderBloc>().add(const OrderEvent.stopAdded())
                          : null,
                      onRemovePressed: !isFirst && !isLast
                          ? () => context.read<OrderBloc>().add(OrderEvent.stopRemoved(index))
                          : null,
                      onQueryChanged: (value) {
                        if (_isSyncing) return;
                        context.read<OrderBloc>().add(OrderEvent.stopQueryChanged(index, value));
                      },
                    ),
                  );
                },
              ),
            ],
          );

          final mapTrigger = OrderMapContextTriggerWidget(
            target: _focusedFieldIndex == null ? OrderLocationTarget.stop : OrderLocationTarget.stop, // Generic stop target
            onTap: () {
              printM('[OrderExpandedSheetWidget] mapTrigger onTap');
              FocusScope.of(context).unfocus();
              context.read<OrderBloc>().add(
                OrderEvent.setOnMapPressed(index: _focusedFieldIndex ?? _activeSearchIndex),
              );
            },
          );

          final confirmButton = AppButton.primary(
            onTap: () {
              printM('[OrderExpandedSheetWidget] confirmLocations onTap');
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

          final isPaymentLoading =
              widget.state.booking.tripRequestStatus.isLoading ||
              widget.state.booking.paymentSheetState.isLoading;

          final vehicleConfirmButton = AppButton.primary(
            onTap: () {
              context.read<OrderBloc>().add(
                const OrderEvent.confirmBookingDetailsPressed(),
              );
            },
            isActive: _isVehicleConfirmActive && !isPaymentLoading,
            isLoading: isPaymentLoading,
            layout: AppButtonLayout(
              width: double.infinity,
              height: 54.sp,
              borderRadius: AppRadii.lg,
            ),
            child: AppButtonChild.label(AppStrings.selectAndPay),
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
                    child: OrderBookingDetailsStepWidget(state: widget.state),
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
                          OrderSchedulePickerWidget(state: widget.state)
                              .animate()
                              .fadeIn(delay: 150.ms)
                              .slideY(begin: 0.1, curve: Curves.easeOutCubic),
                          AppSpacing.md.verticalSpace,
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
