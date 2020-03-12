import 'dart:math';
import 'package:cardgames/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'playingcard.dart';
import 'package:cardgames/solitaire_provider.dart';

class SolitairePage extends StatefulWidget {


  SolitairePage({Key key}) : super(key: key);

  @override
  _SolitairePageState createState() => _SolitairePageState();
}


class _SolitairePageState extends State<SolitairePage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SolitaireProvider>(
      create: (context) => SolitaireProvider(random: Provider.of<MainProvider>(context, listen: false).random),
      child: Builder(
        builder: (context) {
          var pageProvider = Provider.of<SolitaireProvider>(context);
          return Scaffold(
          appBar: AppBar(
            title: Text('Solitare'),
          ),
          body: Center(
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      pageProvider.allCards[pageProvider.rand].image,
                    ]
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => pageProvider.randomizeCard(),
            tooltip: 'Random Card',
            child: Icon(Icons.swap_calls),
          ),
        );
        },
      ),
    );
  }
}
