import 'dart:math';

import 'package:cardgames/widgets/playing_card.dart';
import 'package:flutter/material.dart';

/*
Matrix4 Transformations:
[x, 0, 0, 0,
 0, y, 0, 0,
 0, 0, z, 0,
 x, y, z, 1/sf}
 ^offsets


 */

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _rotation;
  Animation<Offset> _offset;

  @override
  void initState() {
    _controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _rotation = Tween<double>(begin: pi, end: 0).animate(_controller)..addListener(() => setState(() {}));
    _offset = Tween<Offset>(begin: Offset(0.4, 0.4), end: Offset(0.6, 0.4)).animate(_controller)..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final cont = Container(
      width: 50,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        color: Colors.grey.shade200,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.forward),
            onPressed: () {
              print(_controller.status);
              if (_controller.status == AnimationStatus.completed) _controller.reverse();
              else if (_controller.status == AnimationStatus.dismissed) _controller.forward();
            },
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          var size = Size(constraints.maxWidth, constraints.maxHeight);
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: size.width * _offset.value.dx,
                bottom: size.height * _offset.value.dy,
                child: Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.005)
                    ..rotateY(_rotation.value),
                  child: PlayingCardWidget(
                    key: ValueKey(
                      _rotation.value < pi / 2
                    ),
                    card: PlayingCard(suit: CardSuit.hearts, value: CardValue.nine, faceUp: _rotation.value < pi / 2),
                    onTap: () {
                      _controller.forward();
                    },
                  )
                ),
              ),
              Positioned(
                left: size.width * 0.6,
                bottom: size.height * 0.4,
                child: cont,
              )
            ].reversed.toList() ,
          );
        },
      ),
    );
  }


}
