import 'dart:math';

import 'package:cardgames/providers/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'animation_demo.dart';
import 'solitaire_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.portraitUp,
//      DeviceOrientation.portraitDown,
//    ]);
    return ProviderWidget(
      child: MaterialApp(
        title: 'Card Games',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          primaryColorDark: Colors.grey,
        ),
        home: MyHomePage(title: 'Card Games'),
      ),
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
  int _counter = 0;

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_to_home_screen),
            onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => AnimationDemo())),
          )
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            gradient: new LinearGradient(colors: [Colors.red, Colors.cyan])
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'This is my first time using Flutter',
                  ),
                  Text(
                    'You have pushed the button this many times:',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.yellow,
                    ),
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => SolitairePage()),
                      );
                    },
                    child: Text(
                      "Go To Solitaire",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
