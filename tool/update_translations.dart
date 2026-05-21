import 'dart:convert';
import 'dart:io';

void main() {
  final files = ['nl', 'de', 'pl', 'uk', 'fr', 'es', 'ro'];
  for (final file in files) {
    final path = 'assets/l10n/$file.json';
    final content = File(path).readAsStringSync();
    final json = jsonDecode(content) as Map<String, dynamic>;
    json['yourJourneyBeginsHere'] = 'Your journey begins here.';
    json['recentLocations'] = 'Recent locations';
    File(path).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(json));
  }
}
