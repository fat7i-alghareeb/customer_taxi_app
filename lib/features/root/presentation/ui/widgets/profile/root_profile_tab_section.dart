import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/profile/presentation/states/profile_bloc.dart';
import 'package:customertaxi/features/profile/presentation/ui/widgets/profile_body.dart';

class RootProfileTabSection extends StatelessWidget {
  const RootProfileTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileEvent.started()),
      child: const ProfileBody(isSetupMode: false),
    );
  }
}
