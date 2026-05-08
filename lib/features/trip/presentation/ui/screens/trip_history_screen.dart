import 'package:customertaxi/common/imports/imports.dart';
import '../widgets/trip_history_body.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  static const String pagePath = '/trip_history';
  static const String pageName = 'TripHistoryScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(child: const TripHistoryBody());
  }
}
