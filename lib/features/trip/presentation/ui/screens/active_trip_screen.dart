import 'package:customertaxi/common/imports/imports.dart';
import '../widgets/active_trip_body.dart';

class ActiveTripScreen extends StatelessWidget {
  const ActiveTripScreen({super.key});

  static const String pagePath = '/active_trip';
  static const String pageName = 'ActiveTripScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(child: const ActiveTripBody());
  }
}
