import 'package:cardgames/playingcard.dart';
import 'package:cardgames/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cardgames/solitaire_provider.dart';

class SolitairePage extends StatefulWidget {


  SolitairePage({Key key}) : super(key: key);

  @override
  _SolitairePageState createState() => _SolitairePageState();
}


class _SolitairePageState extends State<SolitairePage> {

  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SolitaireProvider>(
      create: (context) => SolitaireProvider(random: Provider.of<MainProvider>(context, listen: false).random),
      child: Builder(
        builder: (context) {
          SolitaireProvider pageProvider = Provider.of<SolitaireProvider>(context);
          return Scaffold(
            backgroundColor: Colors.lightGreen,
            appBar: AppBar(
              title: Text('Solitare'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              color: Colors.grey,
                              width: 200,
                              height: 100,
                            ),
                            Container(
                              color: Colors.pink,
                              width: 200,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              color: Colors.blue,
                              width: 100,
                              height: 100,
                              child: Text(
                                'World',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              color: Colors.blue,
                              width: 100,
                              height: 100,
                              child: Text(
                                'World',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//Draggable<String>(
//child: pageProvider.cardDeckOpened[0].image,
//feedback: pageProvider.cardDeckOpened[0].image,
//childWhenDragging: Container(),
//data: 'Card',
//),

//Container(
//child: DragTarget<String>(
//builder: (context, List<String> candidateData, rejectedData) {
//return accepted ? Padding(
//padding: EdgeInsets.only(top: 100.0),
//child: Container(
//width: 100,
//height: 200,
//color: Colors.black,
//child: pageProvider.cardDeckOpened[0].image,
//),
//) : Container(
//width: 100,
//height: 200,
//color: Colors.blue,
//);
//}, onWillAccept: (data) {
//return true;
//}, onAccept: (data) {
//setState(() {
//accepted = true;
//});
//},
//),
//),

