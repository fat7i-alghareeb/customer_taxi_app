import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/core/services/app_version/app_version_gate_coordinator.dart';

import '../widgets/force_update_body_section.dart';

/// Full-screen block shown when the installed build is older than the minimum
/// supported version.
///
/// Non-dismissible by two independent mechanisms: `PopScope(canPop: false)`
/// stops the system back gesture, and `AppRouteGuard` re-redirects here on every
/// redirect cycle while the flag is set — GoRouter runs `redirect` on pops too,
/// so either alone would suffice and together they leave no gap.
class ForceUpdateScreen extends StatefulWidget {
  const ForceUpdateScreen({super.key});

  static const String pagePath = '/force_update_screen';
  static const String pageName = 'ForceUpdateScreen';

  @override
  State<ForceUpdateScreen> createState() => _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends State<ForceUpdateScreen>
    with WidgetsBindingObserver {
  AppVersionGateCoordinator get _coordinator =>
      getIt<AppVersionGateCoordinator>();

  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    printC('[ForceUpdateScreen] initState');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    printM('[ForceUpdateScreen] lifecycle=$state');
    // Returning from the store re-checks automatically, so an in-place update
    // clears the gate without needing a restart.
    if (state == AppLifecycleState.resumed) {
      _recheck();
    }
  }

  @override
  void dispose() {
    printC('[ForceUpdateScreen] dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _recheck() async {
    if (_isChecking) {
      printM('[ForceUpdateScreen] recheck skipped (already running)');
      return;
    }

    setState(() => _isChecking = true);

    // The router reacts on its own via the coordinator's notifyListeners();
    // this screen never navigates.
    await _coordinator.refresh();

    if (!mounted) return;
    setState(() => _isChecking = false);
  }

  Future<void> _openStore() async {
    final launched = await _coordinator.openStore();
    if (launched || !mounted) return;

    printY('[ForceUpdateScreen] store launch failed');
    showErrorOverlay(context, AppStrings.forceUpdateStoreOpenFailed);
  }

  @override
  Widget build(BuildContext context) {
    final coordinator = _coordinator;

    return PopScope(
      // No onPopInvokedWithResult: back should do nothing at all, not exit
      // the app.
      canPop: false,
      child: AppScaffold.body(
        scaffoldConfig: const AppScaffoldConfig(
          safeArea: [AppScaffoldSafeArea.top, AppScaffoldSafeArea.bottom],
        ),
        child: Center(
          child: ForceUpdateBodySection(
            installedVersion: coordinator.installedVersion,
            latestVersion: coordinator.latestVersion.isNotEmpty
                ? coordinator.latestVersion
                : coordinator.minimumRequiredVersion,
            hasStoreUrl: coordinator.hasStoreUrl,
            isChecking: _isChecking,
            onUpdate: _openStore,
            onRecheck: _recheck,
          ),
        ),
      ),
    );
  }
}
