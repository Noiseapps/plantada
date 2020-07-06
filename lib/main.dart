import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:plantada/coreViews/app_bar.dart';
import 'package:plantada/scoreboard/scoreboard_widget.dart';

import 'menu.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(title: 'PLANTADA'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      this.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _WidgetWrapper center = _centerWidget(this.currentIndex);
    var appBar = PlantadaAppBarProvider.appBar(widget.title, center.appBarActions);
    return Scaffold(
      appBar: appBar,
      body: center.mainWidget,
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomTabs(),
        currentIndex: currentIndex,
        unselectedItemColor: Colors.blue[400],
        selectedItemColor: Colors.blue[900],
        onTap: onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<BottomNavigationBarItem> _bottomTabs() {
    return BottomBarItem.values().map((bottomItem) => BottomNavigationBarItem(icon: Icon(bottomItem.icon), title: Text(bottomItem.title))).toList();
  }

  _WidgetWrapper _centerWidget(int activeTab) {
    var tabItem = BottomBarItem.atIndex(activeTab);
    switch (tabItem) {
      case BottomBarItem.score:
        var scoreboardWidget = ScoreboardWidget();
        var actions = [
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              scoreboardWidget.startNewGame();
            },
          )
        ];
        return _WidgetWrapper(scoreboardWidget, actions);
      default:
        var widget = Center(
          child: Text("Coming soon"),
        );
        return _WidgetWrapper(widget);
    }
  }
}

class _WidgetWrapper {
  final List<Widget> _appBarActions;
  final Widget mainWidget;

  const _WidgetWrapper(this.mainWidget, [this._appBarActions]);

  List<Widget> get appBarActions => _appBarActions ?? List();
}
