import 'package:flutter/material.dart';

enum Resource {
  cigarettes,
  booze,
  weed,
  guns,
  coke,
}

extension ResourceDisplayName on Resource {
  String name() {
    return this.toString().split('.').last;
  }
}

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
