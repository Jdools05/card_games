import 'dart:math';
import 'package:cardgames/playingCard.dart'; // Imports should always use the package:cardgames/dot_dot_dot.dart not the dot_dot_dot.dart format
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Avoid global variables, everything should be in the widget tree
@deprecated List<PlayingCard> allCards = [];

@immutable // Variables in the class can be changed, that being said they
           // shouldn't and their changes don't cause the widget tree to rebuild
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    populateCards();
    return MaterialApp(
      title: 'Card Games',
      theme: ThemeData.light().copyWith(primaryColor: Colors.green, primaryAccentColor: Colors.greenAccent),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.green, primaryAccentColor: Colors.greenAccent),
      home: MyHomePage(title: 'Card Games'),
    );
  }

  void populateCards() {
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        allCards.add(PlayingCard( // The new keyword is not required as of Dart 2.0
          cardType: type,
          cardSuit: suit,
          faceUp: false,
        ));
      });
    });
  }
  
}

@immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Make these private unless they are useful and doesn't break anything outside the class
  int _rand = 0; // In dart _x is private and x is public

  void _incrementCounter() {
    setState(() {
      _counter++;
      rand = Random().nextInt(allCards.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/2C.png', scale: 8),
                Text(
                  // ''' makes it a multi line string
                  '''This is your card: ${allCards[rand].cardType} of ${allCards[rand].cardSuit}
                  This is my first time using Flutter''',
                ),
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),// This trailing comma makes auto-formatting nicer for build methods.
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
