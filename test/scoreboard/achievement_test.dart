import 'package:flutter_test/flutter_test.dart';
import 'package:plantada/data/achievement.dart';
import 'package:plantada/data/player.dart';
import 'package:plantada/scoreboard/game.dart';
import 'package:plantada/utils/data_provider.dart';

void main() {
  grantShouldIncreaseScore();
  grantShouldDisableAchievement();
  grantingSameAchievementAgainShouldHaveNoEffect();

  revokeAchievementShouldEnableAchievement();
  revokeShouldDecreaseScore();
}

void grantShouldDisableAchievement() {
  test('Granting achievement should disable this achievement', () {
    var game = Game.get();
    game.start();
    game.grantAchievement(Achievement.aviator, Player.player1);

    expect(game.isAchievementAvailable(Achievement.aviator), false);
    expect(game.isAchievementAvailable(Achievement.undercover), true);
  });
}



void revokeAchievementShouldEnableAchievement() {
  test('Revoking achievement should enable this achievement', () {
    var game = Game.get();
    game.start();
    game.grantAchievement(Achievement.aviator, Player.player1);

    expect(game.isAchievementAvailable(Achievement.aviator), false);
    expect(game.isAchievementAvailable(Achievement.undercover), true);

    game.revokeAchievement(Achievement.aviator);
    expect(game.isAchievementAvailable(Achievement.aviator), true);
    expect(game.isAchievementAvailable(Achievement.undercover), true);

  });
}

void revokeShouldDecreaseScore() {
  test('Revoking achievement should decrease player score', () {
    var game = Game.get();
    game.start();
    var provider = ProviderFactory.activeProvider();
    var achievementScore = provider.getAchievements().firstWhere((element) => element.achievement == Achievement.aviator).score;

    game.grantAchievement(Achievement.aviator, Player.player1);
    expect(game.playerScore(Player.player1), achievementScore);

    game.revokeAchievement(Achievement.aviator);
    expect(game.playerScore(Player.player1), 0);
  });
}

void grantShouldIncreaseScore() {
  test('Granting achievement should increase player score', () {
    var game = Game.get();
    game.start();
    var provider = ProviderFactory.activeProvider();
    var achievementScore = provider.getAchievements().firstWhere((element) => element.achievement == Achievement.aviator).score;

    expect(game.playerScore(Player.player1), 0);

    game.grantAchievement(Achievement.aviator, Player.player1);

    expect(game.playerScore(Player.player1), achievementScore);
  });
}

void grantingSameAchievementAgainShouldHaveNoEffect() {
  test('Granting achievement again should not increase player score', () {
    var game = Game.get();
    game.start();
    var provider = ProviderFactory.activeProvider();
    var achievementScore = provider.getAchievements().firstWhere((element) => element.achievement == Achievement.aviator).score;

    expect(game.playerScore(Player.player1), 0);

    game.grantAchievement(Achievement.aviator, Player.player1);

    expect(game.playerScore(Player.player1), achievementScore);

    game.grantAchievement(Achievement.aviator, Player.player1);

    expect(game.playerScore(Player.player1), achievementScore);
  });
}
