import 'dart:convert';
import 'dart:io';

void main() {
  final translations = {
    'es': {
      'upcomingTrips': 'Próximos',
      'pastTrips': 'Viajes pasados',
      'scheduledForLabel': 'Programado para {time}',
      'tripLeadTimeError': 'La hora programada debe ser al menos 15 minutos en el futuro.',
      'tripStopCompletedAt': 'Completado a las {time}',
    },
    'fr': {
      'upcomingTrips': 'À venir',
      'pastTrips': 'Trajets passés',
      'scheduledForLabel': 'Planifié pour {time}',
      'tripLeadTimeError': 'L\'heure programmée doit être d\'au moins 15 minutes dans le futur.',
      'tripStopCompletedAt': 'Terminé à {time}',
    },
    'pl': {
      'upcomingTrips': 'Nadchodzące',
      'pastTrips': 'Minione przejazdy',
      'scheduledForLabel': 'Zaplanowane na {time}',
      'tripLeadTimeError': 'Zaplanowany czas musi być o co najmniej 15 minut w przyszłość.',
      'tripStopCompletedAt': 'Ukończono o {time}',
    },
    'ro': {
      'upcomingTrips': 'Viitoare',
      'pastTrips': 'Curse anterioare',
      'scheduledForLabel': 'Programată pentru {time}',
      'tripLeadTimeError': 'Ora programată trebuie să fie cu cel puțin 15 minute în viitor.',
      'tripStopCompletedAt': 'Finalizată la {time}',
    },
    'uk': {
      'upcomingTrips': 'Найближчі',
      'pastTrips': 'Минулі поїздки',
      'scheduledForLabel': 'Заплановано на {time}',
      'tripLeadTimeError': 'Запланований час має бути щонайменше на 15 хвилин у майбутньому.',
      'tripStopCompletedAt': 'Завершено о {time}',
    }
  };

  for (final entry in translations.entries) {
    final lang = entry.key;
    final keys = entry.value;
    final path = 'assets/l10n/$lang.json';
    final file = File(path);
    if (!file.existsSync()) {
      print('File not found: $path');
      continue;
    }
    final content = file.readAsStringSync();
    final json = jsonDecode(content) as Map<String, dynamic>;
    
    // Add keys only if they do not exist
    var updated = false;
    for (final k in keys.entries) {
      if (!json.containsKey(k.key)) {
        json[k.key] = k.value;
        updated = true;
      }
    }
    if (updated) {
      final encoder = const JsonEncoder.withIndent('  ');
      file.writeAsStringSync(encoder.convert(json) + '\n');
      print('Updated $path');
    } else {
      print('No updates needed for $path');
    }
  }
}
