import 'package:customertaxi/common/imports/imports.dart';

/// Compact "time until pickup" label — `2 u 15 min`, `45 min`, `3 d 4 u`.
///
/// Shared by the reserved-trip banner on the map and the Upcoming section of
/// the trips tab so the same reservation never reads differently in two places.
/// Returns null once the pickup time has passed; callers show "starting now".
String? formatTimeUntil(DateTime whenUtc, {DateTime? nowUtc}) {
  final remaining = whenUtc.toUtc().difference(nowUtc ?? DateTime.now().toUtc());
  if (remaining <= Duration.zero) return null;

  final days = remaining.inDays;
  final hours = remaining.inHours % 24;
  final minutes = remaining.inMinutes % 60;

  final parts = <String>[];
  if (days > 0) {
    parts.add('$days ${AppStrings.timeUnitDayShort}');
    if (hours > 0) parts.add('$hours ${AppStrings.timeUnitHourShort}');
  } else if (remaining.inHours > 0) {
    parts.add('${remaining.inHours} ${AppStrings.timeUnitHourShort}');
    if (minutes > 0) parts.add('$minutes ${AppStrings.timeUnitMinuteShort}');
  } else {
    // Round up so a pickup 30 seconds out never reads "0 min".
    final mins = remaining.inMinutes < 1 ? 1 : remaining.inMinutes;
    parts.add('$mins ${AppStrings.timeUnitMinuteShort}');
  }

  return parts.join(' ').toLatinDigits();
}

/// `Starts in 2 u 15 min`, or `Starting now` once the window has opened.
String formatStartsIn(DateTime whenUtc, {DateTime? nowUtc}) {
  final until = formatTimeUntil(whenUtc, nowUtc: nowUtc);
  if (until == null) return AppStrings.tripStartsNow;
  return AppStrings.tripStartsIn.replaceAll('{time}', until);
}
