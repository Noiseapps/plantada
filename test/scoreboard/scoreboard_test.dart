import 'package:flutter_test/flutter_test.dart';
import 'package:plantada/data/player.dart';
import 'package:plantada/data/resource.dart';
import 'package:plantada/scoreboard/scoreboard.dart';

void main() {
  test('Player resource count should be incremented', () {
    final scoreboard = getScoreboard();
    scoreboard.addResourceToPlayer(Player.player1, Resource.cigarettes);
    expect(scoreboard.getPlayerResourceCount(Player.player1, Resource.cigarettes), 1);
    scoreboard.addResourceToPlayer(Player.player1, Resource.cigarettes);
    expect(scoreboard.getPlayerResourceCount(Player.player1, Resource.cigarettes), 2);
    scoreboard.addResourceToPlayer(Player.player1, Resource.cigarettes);
    expect(scoreboard.getPlayerResourceCount(Player.player1, Resource.cigarettes), 3);
    scoreboard.addResourceToPlayer(Player.player1, Resource.cigarettes);
    expect(scoreboard.getPlayerResourceCount(Player.player1, Resource.cigarettes), 4);
  });

  test('Player score should be reset after round ends', () {
    // given
    final scoreboard = getScoreboard();
    scoreboard.addResourceToPlayer(Player.player1, Resource.cigarettes);
    expect(scoreboard.getPlayerResourceCount(Player.player1, Resource.cigarettes), 1);

//    when
    scoreboard.finalizeRound();

//    then
    expect(scoreboard.getPlayerResourceCount(Player.player1, Resource.cigarettes), 0);
  });

  test('Overflowing production should reduce all player income', () {
//    given
    final scoreboard = getScoreboard();
    scoreboard.addResourceToPlayer(Player.player1, Resource.guns);
    scoreboard.addResourceToPlayer(Player.player1, Resource.guns);
    scoreboard.addResourceToPlayer(Player.player1, Resource.guns);

    scoreboard.addResourceToPlayer(Player.player3, Resource.guns);

    scoreboard.addResourceToPlayer(Player.player2, Resource.guns);
    scoreboard.addResourceToPlayer(Player.player2, Resource.coke);
    scoreboard.addResourceToPlayer(Player.player2, Resource.coke);

//    when
    var roundScore = scoreboard.finalizeRound();

//    then
    expect(roundScore[Player.player1], 12);
    expect(roundScore[Player.player2], 16);
    expect(roundScore[Player.player3], 4);
  });

  test('Resource short name should return enum name', () {
    expect(Resource.cigarettes.name(), 'cigarettes');
    expect(Resource.booze.name(), 'booze');
    expect(Resource.weed.name(), 'weed');
    expect(Resource.guns.name(), 'guns');
    expect(Resource.coke.name(), 'coke');
  });
}

Scoreboard getScoreboard() {
  return Scoreboard.load(getConfig());
}

ScoreboardConfig getConfig() {
  return ScoreboardConfig(config: {
    Resource.cigarettes: ThresholdData(steps: [ThresholdStep(8, 2), ThresholdStep(1000, 1)]),
    Resource.booze: ThresholdData(steps: [ThresholdStep(6, 3), ThresholdStep(10, 2), ThresholdStep(1000, 1)]),
    Resource.weed: ThresholdData(steps: [ThresholdStep(6, 4), ThresholdStep(10, 3), ThresholdStep(1000, 2)]),
    Resource.guns: ThresholdData(steps: [ThresholdStep(4, 5), ThresholdStep(10, 4), ThresholdStep(1000, 2)]),
    Resource.coke: ThresholdData(steps: [ThresholdStep(4, 6), ThresholdStep(8, 5), ThresholdStep(1000, 4)]),
  });
}
