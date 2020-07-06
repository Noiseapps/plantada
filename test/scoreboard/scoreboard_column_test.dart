import 'package:flutter_test/flutter_test.dart';
import 'package:plantada/data/resource.dart';
import 'package:plantada/scoreboard/scoreboard.dart';

void main() {
  test('Should return correct money for player', () {
    final column = ScoreboardColumn(
        Resource.cigarettes,
        ThresholdData(steps: [
          ThresholdStep(4, 4),
          ThresholdStep(8, 3),
          ThresholdStep(12, 2),
        ]));
  });
}
