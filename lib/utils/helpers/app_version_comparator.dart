/// Compares dotted app version strings such as `1.0.3`.
///
/// Hand-rolled rather than pulling in `pub_semver`: this app's dependency graph
/// is already double-capped (`device_info_plus` by syncfusion, `share_plus` by
/// the win32 5/6 split), and `Version.parse` *throws* on `1.2`, on `''`, and on
/// anything that is not strict semver. Our inputs are admin-typed free text read
/// on the startup path, so a throwing parser would have to be wrapped in exactly
/// the fail-open logic implemented here anyway.
class AppVersionComparator {
  AppVersionComparator._();

  /// Guards against `int.tryParse` overflow on absurd input.
  static const int _maxSegmentDigits = 9;

  /// Returns a negative number when [a] is older than [b], zero when they are
  /// equal, and a positive number when [a] is newer.
  ///
  /// Returns `null` when either side cannot be parsed. Callers MUST treat `null`
  /// as "skip the check" so a malformed remote value can never brick the app.
  static int? compare(String a, String b) {
    final left = _parse(a);
    final right = _parse(b);

    if (left == null || right == null) return null;

    final length = left.length > right.length ? left.length : right.length;
    for (var i = 0; i < length; i++) {
      // Zero-pad the shorter side so "1.2" == "1.2.0" == "1.2.0.0".
      final l = i < left.length ? left[i] : 0;
      final r = i < right.length ? right[i] : 0;
      if (l != r) return l.compareTo(r);
    }

    return 0;
  }

  /// Whether [current] is strictly older than [threshold].
  ///
  /// An uncomparable pair is never "below" — this single line is the fail-open
  /// hinge for the whole update gate.
  static bool isBelow(String current, String threshold) {
    final result = compare(current, threshold);
    return result != null && result < 0;
  }

  /// `v1.2.3-beta+7` -> `[1, 2, 3]`, or `null` when unparseable.
  ///
  /// The pre-release suffix is truncated rather than ordered below the release:
  /// treating `1.2.3-beta` as *older* than `1.2.3` would force-update testers
  /// mid-QA, and store-published versions are never pre-release.
  static List<int>? _parse(String value) {
    var text = value.trim();
    if (text.isEmpty) return null;

    if (text.startsWith('v') || text.startsWith('V')) {
      text = text.substring(1);
    }

    for (final separator in const ['-', '+']) {
      final index = text.indexOf(separator);
      if (index != -1) text = text.substring(0, index);
    }

    text = text.trim();
    if (text.isEmpty) return null;

    final parts = text.split('.');
    final segments = <int>[];

    for (final part in parts) {
      if (part.isEmpty || part.length > _maxSegmentDigits) return null;

      final segment = int.tryParse(part);
      // int.tryParse accepts a leading sign; versions never carry one.
      if (segment == null || segment < 0) return null;

      segments.add(segment);
    }

    return segments.isEmpty ? null : segments;
  }
}
