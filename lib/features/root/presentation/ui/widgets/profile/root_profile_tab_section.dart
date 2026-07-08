import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/profile/presentation/states/profile_bloc.dart';
import 'package:customertaxi/features/profile/presentation/ui/widgets/account/account_hub_body.dart';

class RootProfileTabSection extends StatelessWidget {
  const RootProfileTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    // ProfileBloc is kept for the delete-account action inside the hub;
    // profile fields are read reactively from AuthStateNotifier.
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileEvent.started()),
      child: const AccountHubBody(),
    );
  }
}
