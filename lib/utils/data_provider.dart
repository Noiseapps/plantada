import 'package:plantada/data/achievement.dart';
import 'package:plantada/data/resource.dart';
import 'package:plantada/scoreboard/scoreboard.dart';

class ProviderFactory {
  static DataProvider _provider = new DefaultDataProvider();

  static withProvider(DataProvider provider) {
    ProviderFactory._provider = provider;
  }

  static DataProvider activeProvider() {
    return _provider;
  }
}

class DataProvider {
  ScoreboardConfig getConfig() {}

  List<AchievementData> getAchievements() {}

  int targetScore() {}

  void setTargetScore(int score) {}

  static final defaultProvider = DefaultDataProvider();
}

class DefaultDataProvider implements DataProvider {
  int _score = 400;

  @override
  List<AchievementData> getAchievements() {
    return AchievementData.list();
  }


  @override
  ScoreboardConfig getConfig() {
    return ScoreboardConfig(config: {
      Resource.cigarettes: ThresholdData(steps: [ThresholdStep(8, 2), ThresholdStep(1000, 1)]),
      Resource.booze: ThresholdData(steps: [ThresholdStep(6, 3), ThresholdStep(10, 2), ThresholdStep(1000, 1)]),
      Resource.weed: ThresholdData(steps: [ThresholdStep(6, 4), ThresholdStep(10, 3), ThresholdStep(1000, 2)]),
      Resource.guns: ThresholdData(steps: [ThresholdStep(4, 5), ThresholdStep(10, 4), ThresholdStep(1000, 2)]),
      Resource.coke: ThresholdData(steps: [ThresholdStep(4, 6), ThresholdStep(8, 5), ThresholdStep(1000, 4)]),
    });
  }

  @override
  int targetScore() {
    return _score;
  }

  @override
  void setTargetScore(int score) {
    _score = score;
  }
}
