import 'package:flutter/material.dart';
import 'package:plantada/scoreboard/scoreboard.dart';

class BottomBarItem {
  const BottomBarItem._(this.icon, this.title);

  final IconData icon;
  final String title;

  static const BottomBarItem score = BottomBarItem._(Icons.score, "Wyniki");
  static const BottomBarItem legend = BottomBarItem._(Icons.info, "Legenda");
  static const BottomBarItem rules = BottomBarItem._(Icons.art_track, "Zasady");

  static List<BottomBarItem> values() {
    return [score, legend, rules];
  }

  static BottomBarItem atIndex(int index) {
    if (index >= 0 && index < values().length) {
      return values()[index];
    } else {
      return null;
    }
  }
}

class DataProvider {
  ScoreboardConfig getConfig() {}

  int targetScore() {}

  void setScore(int score) {}

  static final defaultProvider = DefaultDataProvider();
}

class DefaultDataProvider implements DataProvider {
  int _score = 400;

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
  void setScore(int score) {
    _score = score;
  }
}
