import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:customertaxi/core/theme/app_theme.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_no_driver_overlay.dart';

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  Locale locale = const Locale('nl'),
}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        locale: locale,
        // No easy_localization delegate here: AppStrings getters call
        // 'key'.tr() which, without a loaded bundle, returns the key itself —
        // fine for structural assertions (button presence / phase / callbacks).
        home: Scaffold(body: child),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('prompt phase shows two actions and NO close button', (
    tester,
  ) async {
    var postponed = false;
    var cancelled = false;

    await _pump(
      tester,
      TripNoDriverOverlay(
        postponeStatus: const BlocStatus<void>.initial(),
        cancelStatus: const BlocStatus<void>.initial(),
        onPostpone: () => postponed = true,
        onCancel: () => cancelled = true,
        onDone: () {},
      ),
    );

    // No close / X affordance anywhere (blocking overlay).
    expect(find.byIcon(Icons.close), findsNothing);

    // Two action buttons present.
    expect(find.text('noDriverPostponeButton'), findsOneWidget);
    expect(find.text('tripCancelButton'), findsOneWidget);
    // Apology copy not shown yet.
    expect(find.text('done'), findsNothing);

    await tester.tap(find.text('noDriverPostponeButton'));
    expect(postponed, isTrue);

    await tester.tap(find.text('tripCancelButton'));
    expect(cancelled, isTrue);

    // Drain AppButton's ~90ms tap-press animation timer before teardown.
    await tester.pump(const Duration(milliseconds: 150));
  });

  testWidgets('apology phase renders once the no-driver cancel succeeds', (
    tester,
  ) async {
    var done = false;

    await _pump(
      tester,
      TripNoDriverOverlay(
        postponeStatus: const BlocStatus<void>.initial(),
        cancelStatus: const BlocStatus<void>.success(null),
        onPostpone: () {},
        onCancel: () {},
        onDone: () => done = true,
      ),
    );

    // Prompt actions gone; apology + Done shown.
    expect(find.text('noDriverPostponeButton'), findsNothing);
    expect(find.text('noDriverCancelledTitle'), findsOneWidget);
    expect(find.text('noDriverCancelledBody'), findsOneWidget);
    expect(find.text('done'), findsOneWidget);

    await tester.tap(find.text('done'));
    expect(done, isTrue);

    // Drain AppButton's ~90ms tap-press animation timer before teardown.
    await tester.pump(const Duration(milliseconds: 150));
  });
}
