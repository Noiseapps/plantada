import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantada/data/achievement.dart';
import 'package:plantada/data/player.dart';
import 'package:plantada/utils/data_provider.dart';

import '../game.dart';

class AchievementsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AchievementsListState();
}

class AchievementsListState extends State<AchievementsList> {
  var game = Game.get();

  @override
  Widget build(BuildContext context) {
    var items = dataRows();
    return ListView.separated(
      padding: const EdgeInsets.all(4),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return items[index];
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  List<AchievementRow> dataRows() {
    var achievements = ProviderFactory.activeProvider().getAchievements();
    return achievements.map((achievementData) {
      var isAvailable = game.isAchievementAvailable(achievementData.achievement);
      var player = game.achievementWonBy(achievementData.achievement);
      return AchievementRow(achievementData, isAvailable, player, this.onAchievementRowTapped, this.onAchievementRowLongPress);
    }).toList();
  }

  void onAchievementRowTapped(AchievementData achievementData) {
    var achievement = achievementData.achievement;
    selectPlayer((player) {
      setState(() {
        game.grantAchievement(achievement, player);
      });
    });
  }

  void selectPlayer(Function(Player player) selectedPlayerCallback) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Player selectedPlayer;
          var players = Player.values;
          return AlertDialog(
            title: Text("Wybierz gracza"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: Colors.black,
                child: Text("Zamknij".toUpperCase()),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  selectedPlayerCallback(selectedPlayer);
                },
                textColor: Colors.blue,
                child: Text("OK".toUpperCase()),
              ),
            ],
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List<Widget>.generate(players.length, (index) {
                    var player = players[index];
                    return RadioListTile<Player>(
                      title: Text(ProviderFactory.activeProvider().playerName(player)),
                      value: player,
                      groupValue: selectedPlayer,
                      onChanged: (value) {
                        setState(() {
                          selectedPlayer = value;
                        });
                      },
                    );
                  }),
                );
              },
            ),
          );
        });
  }

  void onAchievementRowLongPress(AchievementData achievementData) {
    setState(() {
      var achievement = achievementData.achievement;
      game.revokeAchievement(achievement);
    });
  }
}

class AchievementRow extends StatelessWidget {
  final AchievementData achievementData;
  final bool isEnabled;
  final Player wonBy;
  final Function(AchievementData achievementData) onTap;
  final Function(AchievementData achievementData) onLongPress;

  const AchievementRow(this.achievementData, this.isEnabled, this.wonBy, this.onTap, this.onLongPress);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (isEnabled) {
            this.onTap(achievementData);
          }
        },
        onLongPress: () {
          if (!isEnabled) {
            this.onLongPress(achievementData);
          }
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Opacity(
            opacity: isEnabled ? 1.0 : 0.2,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Image(image: AssetImage('assets/icons/achievements/${achievementData.fileName()}.png'), height: 30),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), border: Border.all(width: 1.0, color: Colors.grey[400])),
                          child: Text(
                            "+${achievementData.score} PZ",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.yellow[700], fontSize: 10),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          achievementData.name,
                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                          softWrap: false,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        achievementData.formattedDescription,
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Visibility(
                          visible: !isEnabled,
                          child: Text(
                            wonBy != null ? ProviderFactory.activeProvider().playerName(wonBy) : "",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey[800], fontSize: 15),
                          )),
                    )),
              ],
            ),
          ),
        ));
  }
}
