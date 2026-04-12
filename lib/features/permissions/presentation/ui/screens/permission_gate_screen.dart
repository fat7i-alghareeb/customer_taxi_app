import 'package:flutter/widgets.dart';
import 'package:customertaxi/common/widgets/custom_scaffold/app_scaffold.dart';
import 'package:customertaxi/core/injection/injectable.dart';
import 'package:customertaxi/core/services/permissions/permissions_coordinator.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../widgets/permission_gate_body_section.dart';
import '../widgets/permission_gate_ui_state.dart';

class PermissionGateScreen extends StatefulWidget {
  const PermissionGateScreen({super.key});

  static const String pagePath = '/permission_gate_screen';
  static const String pageName = 'PermissionGateScreen';

  @override
  State<PermissionGateScreen> createState() => _PermissionGateScreenState();
}

class _PermissionGateScreenState extends State<PermissionGateScreen>
    with WidgetsBindingObserver {
  PermissionsCoordinator get _permissionsCoordinator =>
      getIt<PermissionsCoordinator>();

  PermissionGateUiState _uiState = PermissionGateUiState.denied;
  bool _isRunning = false;
  // ignore: unused_field
  bool _settingsOpenedAutomatically = false;

  @override
  void initState() {
    super.initState();
    printC('[PermissionGateScreen] initState');
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runPermissionFlow();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    printM('[PermissionGateScreen] lifecycle=$state');
    if (state == AppLifecycleState.resumed) {
      _settingsOpenedAutomatically = false;
      _runPermissionFlow();
    }
  }

  @override
  void dispose() {
    printC('[PermissionGateScreen] dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _openSettings() async {
    printY('[PermissionGateScreen] openSettings tapped');
    await _permissionsCoordinator.openSettings();
  }

  Future<void> _runPermissionFlow() async {
    if (_isRunning) {
      printM('[PermissionGateScreen] run skipped (already running)');
      return;
    }

    printC('[PermissionGateScreen] run start');
    _isRunning = true;

    // Removed loading state assignment here to prevent showing spinner
    // while checking or requesting permission

    final result = await _permissionsCoordinator.ensurePostSplashPermissions();
    printM('[PermissionGateScreen] run result=$result');

    if (!mounted) {
      printY('[PermissionGateScreen] unmounted before applying result');
      _isRunning = false;
      return;
    }

    switch (result) {
      case PermissionGateResult.granted:
        printG(
          '[PermissionGateScreen] state=loading (granted, waiting router)',
        );
        setState(() => _uiState = PermissionGateUiState.loading);
        break;
      case PermissionGateResult.denied:
        printY('[PermissionGateScreen] state=denied');
        _settingsOpenedAutomatically = false;
        setState(() => _uiState = PermissionGateUiState.denied);
        break;
      case PermissionGateResult.permanentlyDenied:
        printY('[PermissionGateScreen] state=permanentlyDenied');
        setState(() => _uiState = PermissionGateUiState.permanentlyDenied);
        break;
      case PermissionGateResult.locationServiceDisabled:
        printY('[PermissionGateScreen] state=locationServiceDisabled');
        _settingsOpenedAutomatically = false;
        setState(
          () => _uiState = PermissionGateUiState.locationServiceDisabled,
        );
        break;
    }

    _isRunning = false;
    printC('[PermissionGateScreen] run complete');
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: PermissionGateBodySection(
        state: _uiState,
        onOpenSettings: _openSettings,
        onRetry: _runPermissionFlow,
      ),
    );
  }
}
