import 'dart:io';

import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/services/file_download/file_download_service.dart';
import 'package:customertaxi/core/services/file_download/file_saved_result_presenter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vibration/vibration.dart';

import '../../../data/datasources/trip_remote_datasource.dart';
import '../../states/record_ride_cubit.dart';

/// Safety audio-recording sheet shown from the in-trip safety panel. Records
/// while the passenger is in the car, uploads to the server on stop, and keeps a
/// local copy that can be shared from the device.
class RecordRideSheet extends StatelessWidget {
  const RecordRideSheet._({required this.tripId});

  final String tripId;

  static Future<void> show(BuildContext context, {required String tripId}) {
    return AppBottomSheet.show<void>(
      context,
      isDismissible: false,
      enableDrag: false,
      sheet: AppBottomSheet.basic(
        title: AppStrings.recordRideTitle,
        showDragHandle: false,
        child: RecordRideSheet._(tripId: tripId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pushed on the root navigator, so it does not inherit the active-trip
    // accent from the subtree that opened it — apply it here.
    return tripAccentTheme(
      context,
      child: BlocProvider<RecordRideCubit>(
        create: (_) => RecordRideCubit(
          tripId: tripId,
          dataSource: getIt<TripRemoteDataSource>(),
        )..start(),
        child: const _RecordRideView(),
      ),
    );
  }
}

class _RecordRideView extends StatelessWidget {
  const _RecordRideView();

  String _formatElapsed(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _share(BuildContext context, String path) async {
    try {
      await SharePlus.instance.share(
        ShareParams(files: [XFile(path)], subject: AppStrings.recordRideTitle),
      );
    } catch (e) {
      printY('[RecordRideSheet] share failed: $e');
    }
  }

  /// Persists the local recording to a user-visible folder (Downloads / Files)
  /// via the shared [FileDownloadService], then shows the same saved-path dialog
  /// the invoice flow uses so the passenger sees exactly where it landed.
  Future<void> _saveToDevice(BuildContext context, String path) async {
    try {
      final bytes = await File(path).readAsBytes();
      final fileName =
          'customertaxi-ride-${DateTime.now().millisecondsSinceEpoch}.m4a';
      final result = await getIt<FileDownloadService>().saveBytes(
        bytes: bytes,
        fileName: fileName,
        mimeType: 'audio/mp4',
      );
      if (!context.mounted) return;
      await presentFileSaveResult(
        context,
        result,
        onShare: () => _share(context, path),
        dialogTitle: AppStrings.recordRideSavedDialogTitle,
      );
    } catch (e) {
      printY('[RecordRideSheet] save to device failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return BlocBuilder<RecordRideCubit, RecordRideState>(
      builder: (context, state) {
        final cubit = context.read<RecordRideCubit>();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSpacing.sm.verticalSpace,
            _StatusIcon(status: state.status, amplitude: state.amplitude),
            AppSpacing.lg.verticalSpace,
            _StatusText(state: state),
            AppSpacing.xl.verticalSpace,
            ..._actionsForStatus(context, cubit, state, colors),
            AppSpacing.sm.verticalSpace,
          ],
        );
      },
    );
  }

  List<Widget> _actionsForStatus(
    BuildContext context,
    RecordRideCubit cubit,
    RecordRideState state,
    ColorScheme colors,
  ) {
    switch (state.status) {
      case RecordRideStatus.recording:
        return [
          Text(
            _formatElapsed(state.elapsed),
            textAlign: TextAlign.center,
            style: AppTextStyles.s24w700.copyWith(color: colors.onSurface),
          ),
          AppSpacing.lg.verticalSpace,
          AppButton.error(
            onTap: () async {
              await Vibration.vibrate(duration: 30);
              await cubit.stopAndUpload();
            },
            child: AppButtonChild.labelIcon(
              label: AppStrings.recordRideStop,
              icon: IconSource.icon(Icons.stop_rounded),
            ),
          ),
          AppSpacing.md.verticalSpace,
          AppButton.outline(
            onTap: () async {
              await cubit.cancel();
              if (context.mounted) Navigator.pop(context);
            },
            child: AppButtonChild.label(AppStrings.recordRideCancel),
          ),
        ];

      case RecordRideStatus.uploading:
        return [
          AppButton.primary(
            onTap: null,
            isActive: false,
            isLoading: true,
            child: AppButtonChild.label(AppStrings.recordRideUploading),
          ),
        ];

      case RecordRideStatus.uploaded:
        return [
          if (state.canShare) ...[
            AppButton.primary(
              onTap: () => _saveToDevice(context, state.localFilePath!),
              child: AppButtonChild.labelIcon(
                label: AppStrings.recordRideSaveToDevice,
                icon: IconSource.icon(Icons.download_rounded),
              ),
            ),
            AppSpacing.md.verticalSpace,
            AppButton.outline(
              onTap: () => _share(context, state.localFilePath!),
              child: AppButtonChild.labelIcon(
                label: AppStrings.recordRideShare,
                icon: IconSource.icon(Icons.ios_share_rounded),
              ),
            ),
            AppSpacing.md.verticalSpace,
          ],
          AppButton.outline(
            onTap: () => Navigator.pop(context),
            child: AppButtonChild.label(AppStrings.recordRideDone),
          ),
        ];

      case RecordRideStatus.failed:
        return [
          AppButton.primary(
            onTap: () => cubit.retryUpload(),
            child: AppButtonChild.label(AppStrings.recordRideRetry),
          ),
          if (state.canShare) ...[
            AppSpacing.md.verticalSpace,
            AppButton.outline(
              onTap: () => _saveToDevice(context, state.localFilePath!),
              child: AppButtonChild.label(AppStrings.recordRideSaveToDevice),
            ),
            AppSpacing.md.verticalSpace,
            AppButton.outline(
              onTap: () => _share(context, state.localFilePath!),
              child: AppButtonChild.label(AppStrings.recordRideShare),
            ),
          ],
          AppSpacing.md.verticalSpace,
          AppButton.outline(
            onTap: () => Navigator.pop(context),
            child: AppButtonChild.label(AppStrings.recordRideDone),
          ),
        ];

      case RecordRideStatus.permissionDenied:
        return [
          AppButton.primary(
            onTap: () => openAppSettings(),
            child: AppButtonChild.label(AppStrings.recordRideOpenSettings),
          ),
          AppSpacing.md.verticalSpace,
          AppButton.outline(
            onTap: () => Navigator.pop(context),
            child: AppButtonChild.label(AppStrings.recordRideCancel),
          ),
        ];

      case RecordRideStatus.idle:
        return [
          AppButton.primary(
            onTap: null,
            isActive: false,
            isLoading: true,
            child: AppButtonChild.label(AppStrings.recordRideRecording),
          ),
        ];
    }
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.status, required this.amplitude});

  final RecordRideStatus status;
  final double amplitude;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    final (IconData icon, Color color) = switch (status) {
      RecordRideStatus.recording => (Icons.mic_rounded, colors.error),
      RecordRideStatus.uploading => (
        Icons.cloud_upload_rounded,
        colors.primary,
      ),
      RecordRideStatus.uploaded => (Icons.check_circle_rounded, Colors.green),
      RecordRideStatus.failed => (Icons.error_rounded, colors.error),
      RecordRideStatus.permissionDenied => (
        Icons.mic_off_rounded,
        colors.error,
      ),
      RecordRideStatus.idle => (Icons.mic_none_rounded, colors.primary),
    };

    // The pulsing halo grows with the live microphone level while recording.
    final haloScale = status == RecordRideStatus.recording
        ? 1.0 + amplitude * 0.6
        : 1.0;

    return Center(
      child: SizedBox(
        width: 96.r,
        height: 96.r,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 96.r * haloScale,
              height: 96.r * haloScale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.12),
              ),
            ),
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.18),
              ),
              child: Icon(icon, size: 32.r, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusText extends StatelessWidget {
  const _StatusText({required this.state});

  final RecordRideState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    final (String title, String? subtitle) = switch (state.status) {
      RecordRideStatus.recording => (
        AppStrings.recordRideRecording,
        AppStrings.recordRideSubtitle,
      ),
      RecordRideStatus.uploading => (AppStrings.recordRideUploading, null),
      RecordRideStatus.uploaded => (
        AppStrings.recordRideUploaded,
        AppStrings.recordRideUploadedNote,
      ),
      RecordRideStatus.failed => (AppStrings.recordRideFailed, null),
      RecordRideStatus.permissionDenied => (
        AppStrings.recordRidePermissionDenied,
        null,
      ),
      RecordRideStatus.idle => (AppStrings.recordRideSubtitle, null),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.s16w600.copyWith(color: colors.onSurface),
        ),
        if (subtitle != null) ...[
          AppSpacing.sm.verticalSpace,
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.s14w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ],
    );
  }
}
