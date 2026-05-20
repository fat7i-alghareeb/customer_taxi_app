part of 'app_scaffold.dart';

/// Base drawer shell used by [AppScaffold].
///
/// This is intentionally a minimal container:
/// - It only allocates when drawer is enabled.
/// - Width is fixed to 85% of the screen as a consistent compact drawer rule.
class _AppDrawerShell extends StatelessWidget {
  const _AppDrawerShell.start({required this.child})
    : alignment = AlignmentDirectional.centerStart;
  const _AppDrawerShell.end({required this.child})
    : alignment = AlignmentDirectional.centerEnd;

  final Widget? child;
  final AlignmentDirectional alignment;

  @override
  Widget build(BuildContext context) {
    /// Drawer width rule: 85% of the screen width.
    final width = context.screenWidth * 0.85;
    return Align(
      alignment: alignment,
      child: Material(
        color: context.surface,
        child: SizedBox(
          width: width,
          height: double.infinity,
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
