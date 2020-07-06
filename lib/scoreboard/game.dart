import 'package:plantada/data/achievement.dart';
import 'package:plantada/data/player.dart';
import 'package:plantada/data/resource.dart';
import 'package:plantada/scoreboard/scoreboard.dart';
import 'package:plantada/utils/data_provider.dart';

class Round {
  const Round(this.currentRound, this.roundScores);

  final int currentRound;
  final Map<Player, int> roundScores;
}

class Game {
  static Game _gameObject = Game._();

  factory Game.get() => _gameObject;

  Game._() {
    start();
  }

  int _targetScore;
  Scoreboard _scoreboard;
  int _round;
  Map<Player, int> _scores;

  final Map<Achievement, Player> _wonAchievements = {};

  Game start() {
    this._targetScore = ProviderFactory.activeProvider().targetScore();
    this._scoreboard = Scoreboard.load(ProviderFactory.activeProvider().getConfig());
    this._round = 1;
    this._scores = resetGameScores();
    this._wonAchievements.clear();
    return this;
  }

  static Map<Player, int> resetGameScores() => Map.fromIterable(Player.values, key: (player) => player, value: (player) => 0);

  Map<Player, int> _getRoundScore() {
    return _scoreboard.getMoneySummary();
  }

  int playerScore(Player player) {
    return _scores[player] ?? 0;
  }

  int get currentRound {
    return _round;
  }

  Round endRound() {
    var roundScores = _scoreboard.finalizeRound();
    var updatedScores = _scores.entries.map((e) => MapEntry(e.key, e.value + roundScores[e.key] ?? 0));
    _scores = Map.fromIterable(updatedScores, key: (e) => e.key, value: (e) => e.value);
    return Round(_round++, roundScores);
  }

  Player checkWinningPlayer() {
    return _scores.entries.firstWhere((entry) => entry.value >= _targetScore, orElse: () => null)?.key;
  }

  void addResourceToPlayer(Player player, Resource resource) {
    _scoreboard.addResourceToPlayer(player, resource);
  }

  void resetPlayerResource(Player player, Resource resource) {
    _scoreboard.resetPlayerResource(player, resource);
  }

  int getPlayerResourceCount(Player player, Resource resource) {
    return _scoreboard.getPlayerResourceCount(player, resource);
  }

  void addScoreToPlayer(Player player, int score) {
    _scores[player] = (_scores[player] ?? 0) + score;
  }

  void removeScoreFromPlayer(Player player, int score) {
    addScoreToPlayer(player, -score);
  }

  void grantAchievement(Achievement achievement, Player player) {
    if (isAchievementAvailable(achievement)) {
      var achievementData = ProviderFactory.activeProvider().getAchievements().firstWhere((element) => element.achievement == achievement);
      addScoreToPlayer(player, achievementData.score);
      _wonAchievements[achievement] = player;
    }
  }

  void revokeAchievement(Achievement achievement) {
    if (!isAchievementAvailable(achievement)) {
      var achievementData = ProviderFactory.activeProvider().getAchievements().firstWhere((element) => element.achievement == achievement);
      var player = _wonAchievements[achievement];
      removeScoreFromPlayer(player, achievementData.score);
      _wonAchievements[achievement] = null;
    }
  }

  bool isAchievementAvailable(Achievement achievement) {
    return _wonAchievements[achievement] == null;
  }

  Player achievementWonBy(Achievement achievement) {
    return _wonAchievements[achievement];
  }
}
