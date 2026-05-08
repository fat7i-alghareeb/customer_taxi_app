import 'package:customertaxi/common/imports/imports.dart';
import '../widgets/profile_body.dart';
import '../../states/profile_bloc.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  static const String pagePath = '/profile_setup';
  static const String pageName = 'ProfileSetupScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileEvent.started()),
      child: AppScaffold.body(
        child: const ProfileBody(isSetupMode: true),
      ),
    );
  }
}
