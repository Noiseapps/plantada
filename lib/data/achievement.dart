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

  const AchievementData._(this.achievement, this.name, this.formattedDescription, this.score);

  String fileName() {
    return this.achievement.toString().split(".").last;
  }

  static List<AchievementData> list() {
    return [
      AchievementData._(
          Achievement.aviator,
          "Awiator",
          Text.rich(TextSpan(text: "Pierwsza osoba, która posiada ", style: TextStyle(fontSize: 12), children: [
            _styled("Lotnisko i Samolot"),
          ])),
          10),
      AchievementData._(
          Achievement.undercover,
          "Tajniak",
          Text.rich(TextSpan(text: "Pierwsza osoba, która posiada 10 punktów ", style: TextStyle(fontSize: 12), children: [
            _styled("Wpływów Rządowych", Colors.blue),
          ])),
          10),
      AchievementData._(
          Achievement.caregiver,
          "Opiekun",
          Text.rich(TextSpan(text: "Pierwsza osoba, która wybuduje ", style: TextStyle(fontSize: 12), children: [
            _styled("2 Agencje Towarzyskiw"),
          ])),
          10),
      AchievementData._(
          Achievement.kingslayer,
          "Królobójca",
          Text.rich(TextSpan(text: "Pierwsza osoba, która użyje na wrogim bossie ", style: TextStyle(fontSize: 12), children: [
            _styled("Karty \"Areszt\""),
          ])),
          10),
      AchievementData._(
          Achievement.smuggler,
          "Przemytnik",
          Text.rich(TextSpan(text: "Pierwsza osoba, która w jednej turze ", style: TextStyle(fontSize: 12), children: [
            _styled("sprzeda każdy typ towaru"),
          ])),
          10),
      AchievementData._(
          Achievement.warehouseman,
          "Magazynier",
          Text.rich(TextSpan(text: "Pierwsza osoba, która wybuduje ", style: TextStyle(fontSize: 12), children: [
            _styled("3 Magazyny"),
          ])),
          10),
      AchievementData._(
          Achievement.warlord,
          "Watażka",
          Text.rich(TextSpan(text: "Pierwsza osoba, która posiada 10 punktów ", style: TextStyle(fontSize: 12), children: [
            _styled("Wpływów Kryminalnych", Colors.red),
          ])),
          10),
      AchievementData._(
          Achievement.first_blood,
          "Pierwsza krew",
          Text.rich(TextSpan(text: "Pierwsza osoba, która wygra pierwszą ", style: TextStyle(fontSize: 12), children: [
            _styled("Walkę o Wpływy"),
          ])),
          10),
      AchievementData._(
          Achievement.business_shark,
          "Rekin biznesu",
          Text.rich(TextSpan(text: "Pierwsza osoba, która posiada 30 sztuk ", style: TextStyle(fontSize: 12), children: [
            _styled("Monet", Colors.yellow[700]),
          ])),
          10),
      AchievementData._(
          Achievement.tycoon,
          "Potentat",
          Text.rich(TextSpan(text: "Pierwsza osoba, która wybuduje ", style: TextStyle(fontSize: 12), children: [
            _styled("budynek produkcyjny każdego typu towaru"),
          ])),
          10),
    ];
  }

  static TextSpan _styled(String content, [Color color]) {
    return TextSpan(text: content, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color ?? Colors.black));
  }
}
