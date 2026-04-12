import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/constants/app_flow_constants.dart';
import '../../../utils/helpers/colored_print.dart';
import '../storage/storage_service.dart';

/// * OnboardingService
///
/// Persists whether the user has completed onboarding and exposes a
/// simple async API that can be used from anywhere via DI.
@lazySingleton
class OnboardingService extends ChangeNotifier {
  OnboardingService(this._storage);

  final StorageService _storage;

  bool? _finishedCache;
  Future<bool>? _loadInFlight;

  /// * Returns true when onboarding was completed at least once.
  Future<bool> isOnboardingFinished() async {
    if (_finishedCache != null) {
      printM('[OnboardingService] cache hit => $_finishedCache');
      return _finishedCache!;
    }

    if (_loadInFlight != null) {
      printM('[OnboardingService] awaiting in-flight load');
      final resolved = await _loadInFlight!;
      _finishedCache = resolved;
      return resolved;
    }

    printC('[OnboardingService] loading onboarding flag from storage');
    _loadInFlight = _loadFinishedFlag();
    try {
      final resolved = await _loadInFlight!;
      _finishedCache = resolved;

      printC('[OnboardingService] isOnboardingFinished => $_finishedCache');
      return resolved;
    } finally {
      _loadInFlight = null;
    }
  }

  Future<bool> _loadFinishedFlag() async {
    final flag = await _storage.readBool(OnboardingStorageKeys.finished);
    return flag ?? false;
  }

  /// * Marks onboarding as finished and notifies listeners so routers
  ///   and widgets can react.
  Future<void> setOnboardingFinished() async {
    printG('[OnboardingService] setOnboardingFinished requested');
    await _storage.writeBool(OnboardingStorageKeys.finished, true);

    _finishedCache = true;
    _loadInFlight = null;
    printG('[OnboardingService] setOnboardingFinished => true');
    notifyListeners();
  }
}
