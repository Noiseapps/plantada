import 'package:flutter_test/flutter_test.dart';
import 'package:plantada/scoreboard/scoreboard.dart';

void main() {
  test('Should return correct value for each step', () {
    final threshold = getSampleThreshold();

    expect(threshold.exportValueForExportAmount(0), 4);
    expect(threshold.exportValueForExportAmount(2), 4);
    expect(threshold.exportValueForExportAmount(4), 4);
    expect(threshold.exportValueForExportAmount(5), 3);
    expect(threshold.exportValueForExportAmount(8), 3);
    expect(threshold.exportValueForExportAmount(9), 2);
    expect(threshold.exportValueForExportAmount(11), 2);
    expect(threshold.exportValueForExportAmount(12), 2);
    expect(threshold.exportValueForExportAmount(13), 1);
    expect(threshold.exportValueForExportAmount(112), 1);
  });
}

ThresholdData getSampleThreshold() {
  return ThresholdData(steps: [
    ThresholdStep(4, 4),
    ThresholdStep(8, 3),
    ThresholdStep(12, 2),
    ThresholdStep(1000, 1),
  ]);
}
