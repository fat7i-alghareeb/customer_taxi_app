import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants/app_flow_constants.dart';
import '../../../utils/helpers/app_version_comparator.dart';
import '../../../utils/helpers/colored_print.dart';
import 'app_version_config_model.dart';
import 'app_version_service.dart';

/// Outcome of one version evaluation. Exactly one value at a time, so the soft
/// sheet can never appear over the force screen.
enum AppVersionGateDecision { none, softUpdate, forceUpdate }

/// Owns the force/soft update verdict and republishes it to the router.
///
/// Fail-open rules — every one of these yields [AppVersionGateDecision.none]:
///
/// | Situation                              | Force | Soft |
/// |----------------------------------------|-------|------|
/// | master switch off (remote or local)    | no    | no   |
/// | network error / timeout / non-200      | no    | no   |
/// | installed version unreadable           | no    | no   |
/// | platform is neither Android nor iOS    | no    | no   |
/// | minimum blank or malformed             | no    | soft still evaluated |
/// | latest blank or malformed              | force still evaluated | no |
///
/// A blank store URL is deliberately NOT in that table: the gate still applies
/// and the UI simply drops the store button and tells the user to update
/// manually. Letting an unsupported build through because an admin has not
/// pasted a link yet would defeat the point of the gate.
@lazySingleton
class AppVersionGateCoordinator extends ChangeNotifier {
  AppVersionGateCoordinator(this._service);

  final AppVersionService _service;

  AppVersionGateDecision _decision = AppVersionGateDecision.none;
  AppVersionPlatformModel _platform = AppVersionPlatformModel.empty;
  String _installedVersion = '';
  bool _isEvaluated = false;
  bool _hasShownSoftUpdate = false;

  AppVersionGateDecision get decision => _decision;
  bool get isEvaluated => _isEvaluated;

  bool get isForceUpdateRequired =>
      _decision == AppVersionGateDecision.forceUpdate;

  bool get isSoftUpdateAvailable =>
      _decision == AppVersionGateDecision.softUpdate;

  String get storeUrl => _platform.storeUrl;
  bool get hasStoreUrl => _platform.storeUrl.isNotEmpty;
  String get latestVersion => _platform.latestVersion;
  String get minimumRequiredVersion => _platform.minimumRequiredVersion;
  String get installedVersion => _installedVersion;

  /// In-memory only, by design: the soft sheet must appear once per cold start,
  /// not once per widget rebuild and not once ever.
  bool get hasShownSoftUpdate => _hasShownSoftUpdate;

  void markSoftUpdateShown() => _hasShownSoftUpdate = true;

  /// Re-fetches and re-evaluates. Called by the force screen when the app
  /// resumes, so returning from the store clears the gate without a restart.
  Future<void> refresh() async {
    await _service.fetch();
    await evaluate();
  }

  Future<void> evaluate() async {
    try {
      _decision = await _resolveDecision();
    } catch (e) {
      printY('[AppVersionGate] evaluate failed: $e — failing open');
      _decision = AppVersionGateDecision.none;
    }

    _isEvaluated = true;
    notifyListeners();
  }

  Future<AppVersionGateDecision> _resolveDecision() async {
    if (!AppFlowConfig.appUpdateCheckEnabled) {
      printC('[AppVersionGate] disabled locally by AppFlowConfig');
      return AppVersionGateDecision.none;
    }

    final config = _service.current;
    if (!config.enabled) {
      printC('[AppVersionGate] disabled remotely');
      return AppVersionGateDecision.none;
    }

    final platform = _resolvePlatform(config);
    if (platform == null) {
      printC('[AppVersionGate] unsupported platform — skipping');
      return AppVersionGateDecision.none;
    }
    _platform = platform;

    final installed = await _service.installedVersion();
    _installedVersion = installed;
    if (installed.isEmpty) {
      printY('[AppVersionGate] installed version unreadable — failing open');
      return AppVersionGateDecision.none;
    }

    if (!hasStoreUrl) {
      // Not a blocker: the screen drops the store button and shows a manual
      // update hint instead. Logged because it is worth noticing in the field.
      printY('[AppVersionGate] no store url — prompting manual update');
    }

    // Minimum first, so force and soft are mutually exclusive by construction.
    if (AppVersionComparator.isBelow(installed, platform.minimumRequiredVersion)) {
      printM(
        '[AppVersionGate] force update '
        'installed=$installed minimum=${platform.minimumRequiredVersion}',
      );
      return AppVersionGateDecision.forceUpdate;
    }

    if (AppVersionComparator.isBelow(installed, platform.latestVersion)) {
      printM(
        '[AppVersionGate] soft update '
        'installed=$installed latest=${platform.latestVersion}',
      );
      return AppVersionGateDecision.softUpdate;
    }

    printG('[AppVersionGate] up to date installed=$installed');
    return AppVersionGateDecision.none;
  }

  AppVersionPlatformModel? _resolvePlatform(AppVersionConfigModel config) {
    if (Platform.isAndroid) return config.android;
    if (Platform.isIOS) return config.ios;
    return null;
  }

  /// Opens the store listing. Returns false when there is no URL or the launch
  /// fails, so the caller can surface the manual-update message.
  Future<bool> openStore() async {
    if (!hasStoreUrl) return false;

    try {
      return await launchUrl(
        Uri.parse(_platform.storeUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      printY('[AppVersionGate] store launch failed: $e');
      return false;
    }
  }
}
