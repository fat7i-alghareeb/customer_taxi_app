import 'dart:io';

void main() {
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    print('lib directory not found');
    return;
  }

  final redundant = {
    "import 'package:flutter_animate/flutter_animate.dart';",
    'import "package:flutter_animate/flutter_animate.dart";',
    "import 'package:font_awesome_flutter/font_awesome_flutter.dart';",
    'import "package:font_awesome_flutter/font_awesome_flutter.dart";',
  };

  libDir.listSync(recursive: true).forEach((entity) {
    if (entity is File && entity.path.endsWith('.dart')) {
      if (entity.path.endsWith('imports.dart')) return;

      final lines = entity.readAsLinesSync();
      final newLines = <String>[];
      bool changed = false;

      for (final line in lines) {
        if (redundant.contains(line.trim())) {
          changed = true;
          continue;
        }
        newLines.add(line);
      }

      if (changed) {
        entity.writeAsStringSync(newLines.join('\n') + '\n');
        print('Cleaned ${entity.path}');
      }
    }
  });
}
