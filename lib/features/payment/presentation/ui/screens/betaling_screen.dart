import 'package:customertaxi/common/imports/imports.dart';

import '../../states/payment_bloc.dart';
import '../widgets/betaling_body.dart';

class BetalingScreen extends StatelessWidget {
  const BetalingScreen({super.key});

  static const String pagePath = '/betaling';
  static const String pageName = 'BetalingScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (_) => getIt<PaymentBloc>()..add(const PaymentEvent.started()),
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(title: AppStrings.betalingTitle),
        child: const BetalingBody(),
      ),
    );
  }
}
