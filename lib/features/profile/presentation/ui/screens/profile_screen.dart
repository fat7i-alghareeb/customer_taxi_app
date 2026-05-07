import 'package:customertaxi/common/imports/imports.dart';

import '../../states/profile_bloc.dart';
import '../widgets/profile_body.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  static const String pagePath = '/profile_setup';
  static const String pageName = 'ProfileSetupScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileEvent.started()),
      child: const ProfileBody(isSetup: true),
    );
  }
}

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  static const String pagePath = '/profile_edit';
  static const String pageName = 'ProfileEditScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileEvent.started()),
      child: const ProfileBody(isSetup: false),
    );
  }
}
