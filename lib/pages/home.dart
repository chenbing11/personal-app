import 'package:flutter/material.dart';
import 'package:personal_app/pages/custom-picker-page.dart';
import 'package:personal_app/pages/json-picker-page.dart';
import 'package:personal_app/pages/count-down-page.dart';
import 'package:personal_app/pages/join-team-page.dart';
import 'package:personal_app/pages/team-list-page.dart';


class HomePage extends StatefulWidget {
  // HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('小部件'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          RaisedButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(
                      builder: (context) => new CustomPickerPage()
                  )
              ).then((value) => null);
            },
            child: Row(
              children: [
                Text('自定义数据选择器'),
              ],
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(
                      builder: (context) => new JsonPickerPage()
                  )
              ).then((value) => null);
            },
            child: Row(
              children: [
                Text('json数据选择器'),
              ],
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(
                      builder: (context) => new CountDownPage()
                  )
              ).then((value) => null);
            },
            child: Row(
              children: [
                Text('倒计时弹窗'),
              ],
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(
                      builder: (context) => new JoinTeamPage()
                  )
              ).then((value) => null);
            },
            child: Row(
              children: [
                Text('列表页'),
              ],
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(
                      builder: (context) => new TeamListPage()
                  )
              ).then((value) => null);
            },
            child: Row(
              children: [
                Text('企业列表页'),
              ],
            ),
          ),

        ]
      ),
      )
    );
  }
}