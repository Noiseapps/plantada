import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantada/coreViews/app_bar.dart';
import 'package:plantada/scoreboard/achievements/achievements_list.dart';

class AchievementsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AchievementScreenState();
}

class AchievementScreenState extends State<AchievementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlantadaAppBarProvider.appBar("PLANTADA", []),
      body: AchievementsList(),
    );
  }
}
