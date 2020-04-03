import 'dart:math';
import 'package:cardgames/widgets/playing_card.dart';
import 'package:flutter/cupertino.dart';

typedef AnimatedFlippableBuilder = Widget Function(BuildContext context, Animation<double> rotation, Animation<Offset> position);

class AnimatedFlippableWidget extends StatefulWidget {
  final Tween<double> rotation;
  final Alignment alignment;
  final Tween<Offset> position;
  final double zOffset;
  final void Function(AnimationController) onTap;
  final AnimatedFlippableBuilder builder;
  final AnimationController controller;

  const AnimatedFlippableWidget({
    Key key,
    this.rotation,
    this.position,
    this.onTap,
    this.zOffset: 0.006,
    this.alignment: Alignment.centerRight,
    this.builder,
    @required this.controller,
  }) : super(key: key);

  @override
  AnimatedFlippableWidgetState createState() => AnimatedFlippableWidgetState(controller);
}

class AnimatedFlippableWidgetState extends State<AnimatedFlippableWidget>{

  AnimationController _controller;
  Animation<double> _rot;
  Animation<Offset> _pos;


  AnimatedFlippableWidgetState(this._controller);

  @override
  void initState() {
    _controller.addListener(() => setState((){}));
    _rot = (widget.rotation ?? Tween<double>(begin: -pi, end: -2*pi)).animate(_controller);
    _pos = (widget.position ?? Tween<Offset>(begin: Offset(0.1, 0.1), end: Offset(0.3, 0.1))).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.onTap == null) return widget.onTap(_controller);

          if (_controller.status == AnimationStatus.dismissed) _controller.forward();
          else if (_controller.status == AnimationStatus.completed) _controller.reverse();
        },
        child: Transform(
          transform: Matrix4.identity()..setEntry(3, 2, widget.zOffset)..rotateY(_rot.value)..translate(_pos.value.dx, _pos.value.dy),
          alignment: widget.alignment,
          child: widget.builder(context, _rot, _pos),
        )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void flip() {
    if (_controller.status == AnimationStatus.dismissed) _controller.forward();
    else if (_controller.status == AnimationStatus.completed) _controller.reverse();
  }

}