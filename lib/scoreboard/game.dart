import 'package:flutter/material.dart';
import 'package:plantada/scoreboard/scoreboard.dart';
import 'package:plantada/utils/data_provider.dart';

class Round {
  const Round(this.currentRound, this.roundScores);

  final int currentRound;
  final Map<Player, int> roundScores;
}

class Game {
  DataProvider provider = DataProvider.defaultProvider;

  static Game gameObject = Game._();

  factory Game.create() => gameObject;

  Game._() {
    start();
  }

  int _targetScore;
  Scoreboard _scoreboard;
  int _round;
  Map<Player, int> scores;

  Game start() {
    this._targetScore = provider.targetScore();
    this._scoreboard = Scoreboard.load(provider.getConfig());
    this._round = 1;
    this.scores = resetGameScores();
    return this;
  }

  static Map<Player, int> resetGameScores() => Map.fromIterable(Player.values, key: (player) => player, value: (player) => 0);

  Map<Player, int> _getRoundScore() {
    return _scoreboard.getMoneySummary();
  }

  int playerScore(Player player) {
    return scores[player] ?? 0;
  }

  int get currentRound {
    return _round;
  }

  Round endRound() {
    var roundScores = _scoreboard.finalizeRound();
    var updatedScores = scores.entries.map((e) => MapEntry(e.key, e.value + roundScores[e.key] ?? 0));
    scores = Map.fromIterable(updatedScores, key: (e) => e.key, value: (e) => e.value);
    return Round(_round++, roundScores);
  }

  Player checkWinningPlayer() {
    return scores.entries.firstWhere((entry) => entry.value >= _targetScore, orElse: () => null)?.key;
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
}
