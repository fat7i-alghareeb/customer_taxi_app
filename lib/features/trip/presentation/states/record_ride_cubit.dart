import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../core/services/media/audio_recorder_service.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../data/datasources/trip_remote_datasource.dart';

enum RecordRideStatus {
  idle,
  recording,
  uploading,
  uploaded,
  failed,
  permissionDenied,
}

class RecordRideState {
  const RecordRideState({
    this.status = RecordRideStatus.idle,
    this.elapsed = Duration.zero,
    this.amplitude = 0,
    this.localFilePath,
    this.uploadedUrl,
  });

  final RecordRideStatus status;
  final Duration elapsed;
  final double amplitude;

  /// Set once recording stops — kept so the passenger can share the file even
  /// if the upload failed.
  final String? localFilePath;
  final String? uploadedUrl;

  bool get isRecording => status == RecordRideStatus.recording;
  bool get canShare => localFilePath != null;

  RecordRideState copyWith({
    RecordRideStatus? status,
    Duration? elapsed,
    double? amplitude,
    String? localFilePath,
    String? uploadedUrl,
  }) {
    return RecordRideState(
      status: status ?? this.status,
      elapsed: elapsed ?? this.elapsed,
      amplitude: amplitude ?? this.amplitude,
      localFilePath: localFilePath ?? this.localFilePath,
      uploadedUrl: uploadedUrl ?? this.uploadedUrl,
    );
  }
}

/// Drives the in-trip safety recording sheet: capture → stop → upload, while
/// keeping the local file for sharing. Created per-sheet with the trip id.
class RecordRideCubit extends Cubit<RecordRideState> {
  RecordRideCubit({
    required String tripId,
    required TripRemoteDataSource dataSource,
    AudioRecorderService? recorder,
  }) : _tripId = tripId,
       _dataSource = dataSource,
       _recorder = recorder ?? appAudioRecorderService,
       super(const RecordRideState());

  final String _tripId;
  final TripRemoteDataSource _dataSource;
  final AudioRecorderService _recorder;

  Timer? _ticker;
  StreamSubscription<double>? _amplitudeSub;

  Future<void> start() async {
    final failure = await _recorder.start();
    if (isClosed) return;
    if (failure == AudioRecorderFailure.permissionDenied) {
      emit(state.copyWith(status: RecordRideStatus.permissionDenied));
      return;
    }
    if (failure != null) {
      emit(state.copyWith(status: RecordRideStatus.failed));
      return;
    }

    emit(const RecordRideState(status: RecordRideStatus.recording));

    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) return;
      emit(
        state.copyWith(elapsed: state.elapsed + const Duration(seconds: 1)),
      );
    });
    _amplitudeSub = _recorder.amplitude.listen((value) {
      if (isClosed) return;
      emit(state.copyWith(amplitude: value));
    });
  }

  Future<void> stopAndUpload() async {
    await _stopTickers();
    final result = await _recorder.stop();
    if (isClosed) return;
    if (!result.isSuccess) {
      emit(state.copyWith(status: RecordRideStatus.failed));
      return;
    }

    final path = result.filePath!;
    emit(
      state.copyWith(
        status: RecordRideStatus.uploading,
        localFilePath: path,
        elapsed: result.duration,
      ),
    );

    try {
      final url = await _dataSource.uploadTripRecording(
        tripId: _tripId,
        filePath: path,
        durationSeconds: result.duration.inSeconds,
      );
      if (isClosed) return;
      emit(
        state.copyWith(status: RecordRideStatus.uploaded, uploadedUrl: url),
      );
    } catch (e) {
      printY('[RecordRideCubit] upload failed: $e');
      if (isClosed) return;
      // Keep localFilePath so the passenger can still share the recording.
      emit(state.copyWith(status: RecordRideStatus.failed));
    }
  }

  /// Re-attempts the upload after a failure (the local file is still present).
  Future<void> retryUpload() async {
    final path = state.localFilePath;
    if (path == null) return;
    emit(state.copyWith(status: RecordRideStatus.uploading));
    try {
      final url = await _dataSource.uploadTripRecording(
        tripId: _tripId,
        filePath: path,
        durationSeconds: state.elapsed.inSeconds,
      );
      if (isClosed) return;
      emit(
        state.copyWith(status: RecordRideStatus.uploaded, uploadedUrl: url),
      );
    } catch (e) {
      printY('[RecordRideCubit] retry upload failed: $e');
      if (isClosed) return;
      emit(state.copyWith(status: RecordRideStatus.failed));
    }
  }

  Future<void> cancel() async {
    await _stopTickers();
    await _recorder.cancel();
    if (isClosed) return;
    emit(const RecordRideState());
  }

  Future<void> _stopTickers() async {
    _ticker?.cancel();
    _ticker = null;
    await _amplitudeSub?.cancel();
    _amplitudeSub = null;
  }

  @override
  Future<void> close() async {
    await _stopTickers();
    return super.close();
  }
}
