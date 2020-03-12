import 'dart:math';

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
        primarySwatch: Colors.lightBlue,
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

  void _incrementCounter() {
    setState(() {
      _counter++;
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
                Checkbox(
                  value: false,
                  onChanged: (bool newVal) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new SolitairePage(),
                    ));
                  },
                ),
              ],
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

class SolitairePage extends StatefulWidget {
  SolitairePage({Key key}) : super(key: key);

  @override
  _SolitairePageState createState() => _SolitairePageState();
}


class _SolitairePageState extends State<SolitairePage> {
  
  int _rand = 0;
  
  void randomizeCard() {
    setState(() {
      _rand = Random().nextInt(allCards.length);
    });
  }
  
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Solitare'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                allCards[_rand].image,
                Text(
                  'This is your card: ${allCards[_rand].cardType} of ${allCards[_rand].cardSuit}',
                ),
              ]
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: randomizeCard,
        tooltip: 'Random Card',
        child: Icon(Icons.swap_calls),
      ),
    );
  }

}
