import 'package:flutter/material.dart';
import 'package:plantada/scoreboard/scoreboard.dart';

class ResourceColors {
  static final List<MaterialColor> _colors = [Colors.purple, Colors.blue, Colors.green, Colors.brown, Colors.blueGrey];

  static Color bgColor(Resource resource) {
    return _colorWithIntensity(resource, 100);
  }

  static Color iconColor(Resource resource) {
    return _colorWithIntensity(resource, 200);
  }

  static Color textColor(Resource resource) {
    return _colorWithIntensity(resource, 300);
  }

  static Color _colorWithIntensity(Resource resource, int intensity) {
    var colorSwatch = _colors[Resource.values.indexOf(resource)];
    return colorSwatch[intensity];
  }
}