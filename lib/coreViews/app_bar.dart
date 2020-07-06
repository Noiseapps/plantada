import 'package:flutter/material.dart';
import 'package:plantada/main.dart';

class PlantadaAppBarProvider {

  static AppBar appBar(String title, List<Widget> appBarActions) {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontFamily: 'PorterSans'),
      ),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      actions: appBarActions,
    );
  }

}