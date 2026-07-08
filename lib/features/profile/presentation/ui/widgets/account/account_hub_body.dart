import 'package:customertaxi/common/imports/imports.dart';

import 'package:customertaxi/core/domain/user_entity.dart';
import 'package:customertaxi/core/services/session/auth_state_notifier.dart';

import 'package:customertaxi/features/auth/presentation/ui/screens/phone_verification_screen.dart';
import 'package:customertaxi/features/auth/presentation/ui/widgets/unverified_phone_banner.dart';
import 'package:customertaxi/features/profile/constants/account_strings.dart';
import 'package:customertaxi/features/profile/presentation/states/profile_bloc.dart';
import 'package:customertaxi/features/profile/presentation/ui/screens/profile_screen.dart';

import 'account_hero_header.dart';

/// Profile tab body: shows user info directly on the scaffold (no wrapping card).
/// Avatar + name at top, then info rows for phone, email, home address.
/// Edit profile button. Delete account stays only in the Edit screen.
class AccountHubBody extends StatelessWidget {
  const AccountHubBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthStateNotifier>().user ?? const UserEntity();

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        final homeAddress = profileState.currentUser?.homeAddressLabel;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSpacing.xxl.verticalSpace,

              // ── Avatar + Name ──
              _ProfileAvatarSection(user: user),

              AppSpacing.xxl.verticalSpace,

              // ── Unverified phone warning ──
              const UnverifiedPhoneBanner(),

              // ── Info Rows ──
              _InfoRow(
                icon: FontAwesomeIcons.phone,
                label: AppStrings.phoneNumber,
                value: user.phone ?? '—',
                trailing: !user.isPhoneVerified
                    ? _VerifyChip(
                        onTap: () => context
                            .pushNamed(PhoneVerificationScreen.pageName),
                      )
                    : _VerifiedBadge(),
              ).animate().fadeIn(delay: 200.ms, duration: 300.ms).slideX(
                    begin: -0.04,
                    curve: Curves.easeOutCubic,
                  ),

              _InfoDivider(),

              _InfoRow(
                icon: FontAwesomeIcons.solidEnvelope,
                label: AppStrings.contactUsEmail,
                value: (user.email != null && user.email!.isNotEmpty)
                    ? user.email!
                    : '—',
              ).animate().fadeIn(delay: 260.ms, duration: 300.ms).slideX(
                    begin: -0.04,
                    curve: Curves.easeOutCubic,
                  ),

              _InfoDivider(),

              _InfoRow(
                icon: FontAwesomeIcons.locationDot,
                label: AppStrings.profileHomeAddress,
                value: (homeAddress != null && homeAddress.isNotEmpty)
                    ? homeAddress
                    : AccountStrings.accountNoAddress,
              ).animate().fadeIn(delay: 320.ms, duration: 300.ms).slideX(
                    begin: -0.04,
                    curve: Curves.easeOutCubic,
                  ),

              AppSpacing.xxl.verticalSpace,

              // ── Edit Profile Button ──
              AppButton.primary(
                onTap: () => context.pushNamed(ProfileEditScreen.pageName),
                child: AppButtonChild.labelIcon(
                  label: AppStrings.profileEditTitle,
                  icon: IconSource.faIcon(FontAwesomeIcons.penToSquare),
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 300.ms).slideY(
                    begin: 0.08,
                    curve: Curves.easeOutCubic,
                  ),

              AppSpacing.xxl.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}

/// Top section: centered avatar with name + email below.
class _ProfileAvatarSection extends StatelessWidget {
  const _ProfileAvatarSection({required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final name = (user.name != null && user.name!.trim().isNotEmpty)
        ? user.name!.trim()
        : AccountStrings.accountNameFallback;

    return Column(
      children: [
        AccountHeroAvatar(url: user.profilePhotoUrl, size: 100),
        AppSpacing.lg.verticalSpace,
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
        ),
        if (user.email != null && user.email!.isNotEmpty) ...[
          AppSpacing.xs.verticalSpace,
          Text(
            user.email!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyles.s14w400.copyWith(
              color: context.onSurfaceVariant,
            ),
          ),
        ],
      ],
    ).animate().fadeIn(duration: 400.ms).scale(
          begin: const Offset(0.95, 0.95),
          curve: Curves.easeOutCubic,
        );
  }
}

/// A single info row: icon chip, label, value, and optional trailing widget.
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  final FaIconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: context.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadii.md.r),
            ),
            child: Center(
              child: FaIcon(icon, size: 16.r, color: context.primary),
            ),
          ),
          AppSpacing.lg.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.s12w500.copyWith(
                    color: context.onSurfaceVariant,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s14w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            AppSpacing.sm.horizontalSpace,
            trailing!,
          ],
        ],
      ),
    );
  }
}

class _InfoDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.onSurface.withValues(alpha: 0.06),
    );
  }
}

/// Small green verified badge.
class _VerifiedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.solidCircleCheck,
      size: 18.r,
      color: AppColors.success,
    );
  }
}

/// Tappable "Verify" chip for unverified phone.
class _VerifyChip extends StatelessWidget {
  const _VerifyChip({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadii.xl.r),
          border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.triangleExclamation,
              size: 11.r,
              color: AppColors.warning,
            ),
            AppSpacing.xs.horizontalSpace,
            Text(
              AccountStrings.accountVerifyPhone,
              style: AppTextStyles.s12w700.copyWith(color: AppColors.warning),
            ),
          ],
        ),
      ),
    );
  }
}
