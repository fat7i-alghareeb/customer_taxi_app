import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/trip/domain/facade/trip_facade.dart';
import 'package:customertaxi/core/services/media/media_picker_service.dart';

class CompensationClaimResult {
  const CompensationClaimResult({
    required this.note,
    required this.evidenceUrls,
  });

  final String note;
  final List<String> evidenceUrls;
}

class CompensationClaimDialog extends StatefulWidget {
  const CompensationClaimDialog({super.key});

  static Future<CompensationClaimResult?> show(BuildContext context) {
    return showDialog<CompensationClaimResult>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CompensationClaimDialog(),
    );
  }

  @override
  State<CompensationClaimDialog> createState() =>
      _CompensationClaimDialogState();
}

class _CompensationClaimDialogState extends State<CompensationClaimDialog> {
  late final TextEditingController _controller;
  final List<String> _pickedPaths = <String>[];
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return PopScope(
      canPop: !_isUploading,
      child: Material(
        color: Colors.transparent,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.only(bottom: viewInsets.bottom),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 520.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  ),
                  padding: REdgeInsets.all(AppSpacing.xl),
                  margin: REdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.reportDriverDelay,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.s20w700.copyWith(
                          color: colors.onSurface,
                        ),
                      ),
                      AppSpacing.md.verticalSpace,
                      Text(
                        AppStrings.driverLateProofInstructions,
                        style: AppTextStyles.s12w400.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.72),
                        ),
                      ),
                      AppSpacing.lg.verticalSpace,
                      TextField(
                        controller: _controller,
                        enabled: !_isUploading,
                        minLines: 3,
                        maxLines: 5,
                        style: AppTextStyles.s14w400.copyWith(
                          color: colors.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: AppStrings.compensationClaimNoteHint,
                          hintStyle: AppTextStyles.s14w400.copyWith(
                            color: colors.onSurface.withValues(alpha: 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadii.sm.r),
                            borderSide: BorderSide(
                              color: colors.onSurface.withValues(alpha: 0.15),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadii.sm.r),
                            borderSide: BorderSide(
                              color: colors.onSurface.withValues(alpha: 0.1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadii.sm.r),
                            borderSide: BorderSide(color: colors.primary),
                          ),
                        ),
                      ),
                      AppSpacing.md.verticalSpace,
                      AppButton.outline(
                        isActive: !_isUploading,
                        onTap: () async {
                          final result = await appMediaPickerService
                              .pickMultiple();
                          if (!context.mounted) return;
                          if (result.failure != null) {
                            showErrorOverlay(context, AppStrings.uploadFailed);
                            return;
                          }
                          if (result.isSuccess) {
                            setState(() {
                              _pickedPaths
                                ..clear()
                                ..addAll(result.files.map((e) => e.path));
                            });
                          }
                        },
                        child: AppButtonChild.labelIcon(
                          label: _pickedPaths.isEmpty
                              ? AppStrings.attachEvidence
                              : AppStrings.filesAttached.replaceAll(
                                  '{count}',
                                  _pickedPaths.length.toString(),
                                ),
                          icon: IconSource.faIcon(FontAwesomeIcons.paperclip),
                        ),
                      ),
                      if (_isUploading) ...[
                        AppSpacing.md.verticalSpace,
                        const Center(child: CircularProgressIndicator()),
                      ],
                      AppSpacing.xl.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: AppButton.outline(
                              variant: AppButtonVariant.grey,
                              isActive: !_isUploading,
                              onTap: () => Navigator.pop(context),
                              child: AppButtonChild.label(AppStrings.cancel),
                            ),
                          ),
                          AppSpacing.md.horizontalSpace,
                          Expanded(
                            child: AppButton.primaryGradient(
                              isActive: !_isUploading,
                              onTap: () async {
                                final note = _controller.text.trim();
                                if (note.isEmpty) {
                                  showErrorOverlay(
                                    context,
                                    AppStrings.compensationNoteRequired,
                                  );
                                  return;
                                }
                                if (_pickedPaths.isEmpty) {
                                  showErrorOverlay(
                                    context,
                                    AppStrings.compensationEvidenceRequired,
                                  );
                                  return;
                                }

                                var evidenceUrls = const <String>[];
                                if (_pickedPaths.isNotEmpty) {
                                  setState(() => _isUploading = true);
                                  final result = await getIt<TripFacade>()
                                      .uploadCompensationEvidence(_pickedPaths);
                                  if (!context.mounted) return;
                                  setState(() => _isUploading = false);

                                  bool success = false;
                                  result.when(
                                    success: (urls) {
                                      evidenceUrls = urls;
                                      success = true;
                                    },
                                    failure: (_) {
                                      if (context.mounted) {
                                        showErrorOverlay(
                                          context,
                                          AppStrings.uploadFailed,
                                        );
                                      }
                                    },
                                  );
                                  if (!success) return;
                                }
                                if (context.mounted) {
                                  Navigator.pop(
                                    context,
                                    CompensationClaimResult(
                                      note: note,
                                      evidenceUrls: evidenceUrls,
                                    ),
                                  );
                                }
                              },
                              child: AppButtonChild.label(AppStrings.confirm),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
