import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../utils/helpers/colored_print.dart';

enum AudioRecorderFailure { permissionDenied, unavailable }

class AudioRecordingResult {
  const AudioRecordingResult.success(this.filePath, this.duration)
    : failure = null;
  const AudioRecordingResult.failure(this.failure)
    : filePath = null,
      duration = Duration.zero;

  final String? filePath;
  final Duration duration;
  final AudioRecorderFailure? failure;

  bool get isSuccess => filePath != null && failure == null;
}

/// Centralizes microphone capture for the in-trip safety recording. Records to a
/// local AAC/.m4a file in the app documents directory and exposes a live
/// amplitude stream so the UI can draw a level meter. The local file is kept
/// after upload so the passenger can share it.
class AudioRecorderService {
  AudioRecorderService._();

  final AudioRecorder _recorder = AudioRecorder();
  DateTime? _startedAt;
  String? _currentPath;

  /// Emits the normalized (0..1) microphone level while recording.
  Stream<double> get amplitude => _recorder
      .onAmplitudeChanged(const Duration(milliseconds: 200))
      .map(_normalizeAmplitude);

  Future<bool> hasPermission() async {
    try {
      return await _recorder.hasPermission();
    } catch (_) {
      return false;
    }
  }

  /// Begins recording. Returns the failure reason, or null on success.
  Future<AudioRecorderFailure?> start() async {
    try {
      if (!await _recorder.hasPermission()) {
        return AudioRecorderFailure.permissionDenied;
      }
      final dir = await getApplicationDocumentsDirectory();
      final path =
          '${dir.path}/trip_recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
      // Default encoder is AAC-LC (.m4a) — small files, broad playback support.
      await _recorder.start(const RecordConfig(), path: path);
      _currentPath = path;
      _startedAt = DateTime.now();
      printG('[AudioRecorderService] started -> $path');
      return null;
    } catch (e) {
      printY('[AudioRecorderService] start failed: $e');
      return AudioRecorderFailure.unavailable;
    }
  }

  /// Stops recording and returns the captured file + duration.
  Future<AudioRecordingResult> stop() async {
    try {
      final path = await _recorder.stop();
      final duration = _startedAt == null
          ? Duration.zero
          : DateTime.now().difference(_startedAt!);
      _startedAt = null;
      final resolved = path ?? _currentPath;
      _currentPath = null;
      if (resolved == null) {
        return const AudioRecordingResult.failure(
          AudioRecorderFailure.unavailable,
        );
      }
      printG('[AudioRecorderService] stopped -> $resolved (${duration.inSeconds}s)');
      return AudioRecordingResult.success(resolved, duration);
    } catch (e) {
      printY('[AudioRecorderService] stop failed: $e');
      return const AudioRecordingResult.failure(
        AudioRecorderFailure.unavailable,
      );
    }
  }

  /// Cancels and discards the in-progress recording.
  Future<void> cancel() async {
    try {
      await _recorder.cancel();
    } catch (_) {
      // Best-effort cleanup.
    } finally {
      _startedAt = null;
      _currentPath = null;
    }
  }

  Future<void> dispose() => _recorder.dispose();

  // record reports amplitude in dBFS (negative, 0 = loudest). Map a ~-45..0 dB
  // window onto 0..1 for the level meter.
  double _normalizeAmplitude(Amplitude amp) {
    const minDb = -45.0;
    final current = amp.current;
    if (current.isNaN || current.isInfinite) return 0;
    final clamped = current.clamp(minDb, 0.0);
    return (clamped - minDb) / (0 - minDb);
  }
}

final AudioRecorderService appAudioRecorderService = AudioRecorderService._();
