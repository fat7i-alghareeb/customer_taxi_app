import 'package:customertaxi/common/imports/imports.dart';

/// Reusable circular avatar for the profile/account hub.
/// Accepts a network URL or shows a fallback user icon.
class AccountHeroAvatar extends StatelessWidget {
  const AccountHeroAvatar({
    super.key,
    this.url,
    this.size = 72,
  });

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.primary.withValues(alpha: 0.08),
        border: Border.all(
          color: context.primary.withValues(alpha: 0.3),
          width: 2.5.r,
        ),
      ),
      child: ClipOval(
        child: (url != null && url!.isNotEmpty)
            ? AppImageViewer.network(url!, borderRadius: 0)
            : Center(
                child: FaIcon(
                  FontAwesomeIcons.user,
                  size: (size * 0.4).r,
                  color: context.primary.withValues(alpha: 0.5),
                ),
              ),
      ),
    );
  }
}
