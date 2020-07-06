import 'package:flutter/material.dart';
import 'package:plantada/data/achievement.dart';
import 'package:plantada/data/player.dart';
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

  String playerName(Player player) {}

  void setPlayerName(Player player, String name) {}

  static final defaultProvider = DefaultDataProvider();
}

class DefaultDataProvider implements DataProvider {
  int _score = 400;
  Map<Player, String> _names = Map();

  @override
  List<AchievementData> getAchievements() {
    return [
      AchievementData(
          Achievement.aviator,
          "Awiator",
          Text.rich(TextSpan(text: "Pierwsza osoba, która posiada ", style: TextStyle(fontSize: 12), children: [
            _styled("Lotnisko i Samolot"),
          ])),
          10),
      AchievementData(
          Achievement.undercover,
          "Tajniak",
          Text.rich(TextSpan(text: "Pierwsza osoba, która posiada 10 punktów ", style: TextStyle(fontSize: 12), children: [
            _styled("Wpływów Rządowych", Colors.blue),
          ])),
          10),
      AchievementData(
          Achievement.caregiver,
          "Opiekun",
          Text.rich(TextSpan(text: "Pierwsza osoba, która wybuduje ", style: TextStyle(fontSize: 12), children: [
            _styled("2 Agencje Towarzyskiw"),
          ])),
          10),
      AchievementData(
          Achievement.kingslayer,
          "Królobójca",
          Text.rich(TextSpan(text: "Pierwsza osoba, która użyje na wrogim bossie ", style: TextStyle(fontSize: 12), children: [
            _styled("Karty \"Areszt\""),
          ])),
          10),
      AchievementData(
          Achievement.smuggler,
          "Przemytnik",
          Text.rich(TextSpan(text: "Pierwsza osoba, która w jednej turze ", style: TextStyle(fontSize: 12), children: [
            _styled("sprzeda każdy typ towaru"),
          ])),
          10),
      AchievementData(
          Achievement.warehouseman,
          "Magazynier",
          Text.rich(TextSpan(text: "Pierwsza osoba, która wybuduje ", style: TextStyle(fontSize: 12), children: [
            _styled("3 Magazyny"),
          ])),
          10),
      AchievementData(
          Achievement.warlord,
          "Watażka",
          Text.rich(TextSpan(text: "Pierwsza osoba, która posiada 10 punktów ", style: TextStyle(fontSize: 12), children: [
            _styled("Wpływów Kryminalnych", Colors.red),
          ])),
          10),
      AchievementData(
          Achievement.first_blood,
          "Pierwsza krew",
          Text.rich(TextSpan(text: "Pierwsza osoba, która wygra pierwszą ", style: TextStyle(fontSize: 12), children: [
            _styled("Walkę o Wpływy"),
          ])),
          10),
      AchievementData(
          Achievement.business_shark,
          "Rekin biznesu",
          Text.rich(TextSpan(text: "Pierwsza osoba, która posiada 30 sztuk ", style: TextStyle(fontSize: 12), children: [
            _styled("Monet", Colors.yellow[700]),
          ])),
          10),
      AchievementData(
          Achievement.tycoon,
          "Potentat",
          Text.rich(TextSpan(text: "Pierwsza osoba, która wybuduje ", style: TextStyle(fontSize: 12), children: [
            _styled("budynek produkcyjny każdego typu towaru"),
          ])),
          10),
    ];
  }

  TextSpan _styled(String content, [Color color]) {
    return TextSpan(text: content, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color ?? Colors.black));
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

  @override
  String playerName(player) {
    return _names[player] ?? player.displayName();
  }

  @override
  void setPlayerName(player, String name) {
    _names[player] = name;
  }
}
