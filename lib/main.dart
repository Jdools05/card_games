import 'dart:math';

import 'package:cardgames/playingCard.dart' as prefix0;
import 'package:flutter/material.dart';

import 'playingCard.dart';

void main() => runApp(MyApp());

List<PlayingCard> allCards = [];

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    populateCards();
    return MaterialApp(
      title: 'Card Games',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColorDark: Colors.grey,
      ),
      home: MyHomePage(title: 'Card Games'),
    );
  }

  void populateCards() {
    CardSuit.values.forEach((suit){
      CardType.values.forEach((type) {
        allCards.add(new PlayingCard(
          cardType: type,
          cardSuit: suit,
          faceUp: false,
        ));
      });
    });
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
  int rand = 0;

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
                  'This is your card: ${allCards[rand].cardType} of ${allCards[rand].cardSuit}',
                ),
                Text(
                  'This is my first time using Flutter',
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
