import 'package:cardgames/widgets/playing_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DraggablePlayingCard extends StatefulWidget {
  final PlayingCardWidget card;
  final VoidCallback onDragStarted;
  final DragEndCallback onDragEnd;
  final VoidCallback onDragCompleted;
  final DraggableCanceledCallback onDraggableCancelled;
  final DraggablePlayingCard data;
  final Widget childWhileDragging;

  DraggablePlayingCard({
    Key key,
    @required this.card,
    this.onDragStarted,
    this.onDragEnd,
    this.onDragCompleted,
    this.onDraggableCancelled,
    this.data,
    this.childWhileDragging,
  }) : super(key: key);

  @override
  _DraggablePlayingCardState createState() => _DraggablePlayingCardState(card: card);
}

class _DraggablePlayingCardState extends State<DraggablePlayingCard> {
  PlayingCardWidget card;
  _DraggablePlayingCardState({this.card});

  @override
  Widget build(BuildContext context) {
    return Draggable<DraggablePlayingCard>(
      data: widget.data ?? widget,
      childWhenDragging: widget.childWhileDragging ?? Container(
        width: card.width,
        height: card.height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          color: Colors.grey.shade400,
        ),
      ),
      child: card,
      feedback: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        duration: Duration(milliseconds: 200),
        builder: (context, value, child) {
          return Transform.scale(scale: value, child: card);
        },
      ),
      onDragStarted: widget.onDragStarted ?? () {},
      onDragEnd: widget.onDragEnd ?? (details) {},
      onDragCompleted: widget.onDragCompleted ?? () {},
      onDraggableCanceled: widget.onDraggableCancelled ?? (v, o) {},
    );
  }


}
