import 'package:flutter/material.dart';

class BottomBarItem {
  const BottomBarItem._(this.icon, this.title);

  final IconData icon;
  final String title;

  static const BottomBarItem score = BottomBarItem._(Icons.score, "Wyniki");
  static const BottomBarItem legend = BottomBarItem._(Icons.info, "Legenda");
  static const BottomBarItem rules = BottomBarItem._(Icons.art_track, "Zasady");

  static List<BottomBarItem> values() {
    return [score, legend, rules];
  }

  static BottomBarItem atIndex(int index) {
    if (index >= 0 && index < values().length) {
      return values()[index];
    } else {
      return null;
    }
  }
}
