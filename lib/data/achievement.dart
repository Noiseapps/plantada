import 'package:flutter/material.dart';

enum Achievement {
  aviator,
  undercover,
  caregiver,
  kingslayer,
  smuggler,
  warehouseman,
  warlord,
  first_blood,
  business_shark,
  tycoon,
}

class AchievementData {
  final Achievement achievement;
  final String name;
  final Text formattedDescription;
  final int score;

  const AchievementData(this.achievement, this.name, this.formattedDescription, this.score);

  String fileName() {
    return this.achievement.toString().split(".").last;
  }
}
