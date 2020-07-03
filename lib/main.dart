import 'package:flutter/material.dart';
import 'package:plantada/scoreboard/scoreboard_widget.dart';

import 'utils/data_provider.dart';

void main() {
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
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
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
    Widget center = _centerWidget(this.currentIndex);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontFamily: 'PorterSans'),
        ),
      ),
      body: _centerWidget(this.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.score),
            title: Text('Wyniki'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('Legenda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label_important),
            title: Text('Zasady'),
          ),
        ],
        currentIndex: currentIndex,
        unselectedItemColor: Colors.blue[400],
        selectedItemColor: Colors.blue[900],
        onTap: onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<BottomNavigationBarItem> _bottomTabs() {
    return BottomBarItem.values().map((bottomItem) => BottomNavigationBarItem(icon: Icon(bottomItem.icon), title: Text(bottomItem.title)));
  }

  Widget _centerWidget(int activeTab) {
    var tabItem = BottomBarItem.atIndex(activeTab);
    switch (tabItem) {
      case BottomBarItem.score:
        return ScoreboardWidget();
      default:
        return Center(
          child: Text("Coming soon"),
        );
    }
  }
}
