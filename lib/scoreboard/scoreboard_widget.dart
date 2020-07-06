import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantada/data/resource.dart';
import 'package:plantada/data/player.dart';
import 'package:plantada/scoreboard/achievements/achievement_screen.dart';
import 'package:plantada/scoreboard/achievements/achievements_list.dart';
import 'package:plantada/utils/data_provider.dart';

import 'game.dart';

class ScoreboardWidget extends StatefulWidget {
  _ScoreboardState _state;

  @override
  _ScoreboardState createState() {
    _state = _ScoreboardState();
    return _state;
  }

  void startNewGame() {
    if (_state != null) {
      _state.startNewGame();
    }
  }
}

class _ScoreboardState extends State<ScoreboardWidget> {
  final game = Game.get();
  bool isGameActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 10,
          child: Row(
            children: <Widget>[
              scores(),
              column(Resource.cigarettes),
              SizedBox(width: 5),
              column(Resource.booze),
              SizedBox(width: 5),
              column(Resource.weed),
              SizedBox(width: 5),
              column(Resource.guns),
              SizedBox(width: 5),
              column(Resource.coke),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  splashColor: Colors.redAccent[100],
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
//                    startNewGame();
                    showAchievements();
                  },
                  child: Text('OSIĄGNIĘCIA'),
                ),
                RaisedButton(
                  splashColor: Colors.greenAccent[100],
                  disabledColor: Colors.grey[300],
                  disabledTextColor: Colors.grey[400],
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: isGameActive
                      ? () {
                          finishRound();
                        }
                      : null,
                  child: Text('ZAKOŃCZ RUNDĘ'),
                ),
              ],
            )),
        SizedBox(height: 10),
      ],
    ));
  }

  Widget scores() {
    return Expanded(
      flex: 1,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.stretch, children: getPlayerScores()),
    );
  }

  List<Widget> getPlayerScores() {
    return <Widget>[
      SizedBox(height: 6),
      SizedBox(
          height: 30,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(1),
                alignment: Alignment.topLeft,
                child: Text('Runda', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text('${game.currentRound}', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
              )
            ],
          )),
      SizedBox(height: 6),
      scoreCell(Player.player1),
      SizedBox(height: 3),
      scoreCell(Player.player2),
      SizedBox(height: 3),
      scoreCell(Player.player3),
      SizedBox(height: 3),
      scoreCell(Player.player4),
    ];
  }

  Widget scoreCell(Player player) {
    return Expanded(
        flex: 1,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.topLeft,
              child: Text(
                player.displayName(),
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "${game.playerScore(player)}",
                style: TextStyle(color: Colors.grey[800], fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  Widget column(Resource resource) {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: getTextChildren(resource),
        ));
  }

  List<Widget> getTextChildren(Resource resource) {
    return <Widget>[
      SizedBox(height: 6),
      SvgPicture.asset('assets/icons/${resource.name()}.svg', height: 30, color: ResourceColors.iconColor(resource)),
      SizedBox(height: 6),
      cell(Player.player1, resource),
      SizedBox(height: 3),
      cell(Player.player2, resource),
      SizedBox(height: 3),
      cell(Player.player3, resource),
      SizedBox(height: 3),
      cell(Player.player4, resource),
    ];
  }

  Expanded cell(Player player, Resource resource) {
    return Expanded(
        flex: 1,
        child: Container(
          child: Material(
              child: Ink(
                  decoration: BoxDecoration(color: ResourceColors.bgColor(resource), borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: InkWell(
                      onTap: () {
                        onResourceTapped(resource, player);
                      },
                      onLongPress: () {
                        onResourceLongPressed(resource, player);
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(4),
                            alignment: Alignment.topLeft,
                            child: Text(
                              player.displayName(),
                              style: TextStyle(color: ResourceColors.textColor(resource), fontSize: 14),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${game.getPlayerResourceCount(player, resource)}",
                              style: TextStyle(color: ResourceColors.textColor(resource), fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )))),
        ));
  }

  void onResourceTapped(Resource resource, Player player) {
    setState(() {
      game.addResourceToPlayer(player, resource);
    });
  }

  void onResourceLongPressed(Resource resource, Player player) {
    setState(() {
      game.resetPlayerResource(player, resource);
    });
  }

  void startNewGame() {
    final inputController = TextEditingController();
    inputController.text = DataProvider.defaultProvider.targetScore().toString();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text("Ostrzeżenie!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Czy jesetś pewien, że chcesz rozpocząć nową grę?'),
                SizedBox(
                  height: 10,
                ),
                Text('Do ilu gracie?'),
                TextField(controller: inputController, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: "Do ilu gracie?"))
              ],
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("ZAMKNIJ"),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    this.isGameActive = true;
                    int score = int.parse(inputController.text);
                    DataProvider.defaultProvider.setTargetScore(score);
                    this.game.start();
                  });
                  Navigator.of(context).pop();
                },
                color: Colors.red,
                child: Text("ROZPOCZNIJ"),
              )
            ],
          );
        });
  }

  void finishRound() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text("Ostrzeżenie!"),
            content: Text('Czy wszystkie pola zostały poprawnie oznaczone i chcesz zakończyć rundę?'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("WRÓĆ"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  finalizeRound();
                },
                color: Colors.red,
                child: Text("NASTĘPNA RUNDA"),
              )
            ],
          );
        });
  }

  void finalizeRound() {
    setState(() {
      var roundResults = game.endRound();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext buildContext) {
            return AlertDialog(
              title: Text("Runda ${roundResults.currentRound} ukończona"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: roundResults.roundScores.entries.map((e) => Text("Wynik ${e.key.displayName()}: ${e.value} punktów")).toList(),
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    checkWinner(context);
                  },
                  color: Colors.blue,
                  child: Text("Zamknij"),
                )
              ],
            );
          });
    });
  }

  void checkWinner(BuildContext context) {
    var winningPlayer = game.checkWinningPlayer();
    if (winningPlayer != null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext buildContext) {
            return AlertDialog(
              title: Text("Gratulacje!"),
              content: Text('Gracz ${winningPlayer.displayName()} wygrywa.'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      this.isGameActive = false;
                    });
                  },
                  color: Colors.blue,
                  child: Text("Zamknij"),
                )
              ],
            );
          });
    }
  }

  void showAchievements() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AchievementsScreen()));
    setState(() {});
  }
}
