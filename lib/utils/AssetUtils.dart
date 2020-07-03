import 'package:flutter/services.dart' show rootBundle;

Future<String> loadScoreboardConfig() async {
  return await rootBundle.loadString('assets/scoreboard.json');
}