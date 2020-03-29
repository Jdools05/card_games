import 'package:cardgames/draggable_playing_card.dart';
import 'package:flutter/material.dart';

class PlayingCardDragTarget extends StatefulWidget {
  final Widget child;
  final Widget childWhileDragging;
  final DragTargetAccept<DraggablePlayingCard> onAccept;
  final DragTargetWillAccept<DraggablePlayingCard> onWillAccept;
  final DragTargetLeave onLeave;

  PlayingCardDragTarget({
    Key key,
    @required this.child,
    this.childWhileDragging,
    this.onWillAccept,
    this.onAccept,
    this.onLeave
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayingCardDragTargetState();
}

class _PlayingCardDragTargetState extends State<PlayingCardDragTarget> {
  DraggablePlayingCard _dragged = null;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return _dragged == null ? DragTarget<DraggablePlayingCard>(
      onWillAccept: widget.onWillAccept ?? (c) => _dragged == null,
      builder: (context, candidates, rejects) => widget.child,
      onAccept: (card) {
        setState(() => _dragged = card);
        if (widget.onAccept != null) widget.onAccept(card);
      },
      onLeave: widget.onLeave ?? (o) {},
    ) : DraggablePlayingCard(
      data: _dragged,
      card: _dragged.card,
      onDragCompleted: () => setState(() => _dragging = false),
      onDragEnd: (details) {
        if (details.wasAccepted) setState(() {
          _dragging = false;
          return _dragged = null;
        });
      },
      onDragStarted: () => setState(() => _dragging = true),
    );
  }
}
