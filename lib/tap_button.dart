import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
//import 'package:keyboard_example/tap_events.dart';

import 'tap_events.dart';

class TapButton extends PositionComponent with TapCallbacks {
  TapButton() : super(anchor: Anchor.center);

  final _paint = Paint()..color = Color.fromARGB(68, 97, 7, 7);

  /// We will store all current circles into this map, keyed by the `pointerId`
  /// of the event that created the circle.
  final Map<int, ExpandingCircle> _circles = {};

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    // size = canvasSize - Vector2(100, 75);
    // if (size.x < 100 || size.y < 100) {
    //   size = canvasSize * 0.9;
    // }
    // position = canvasSize / 2;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final circle = ExpandingCircle(event.localPosition);
    _circles[event.pointerId] = circle;
    add(circle);
    print("object asdasd");
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    _circles[event.pointerId]!.accent();
  }

  @override
  void onTapUp(TapUpEvent event) {
    _circles.remove(event.pointerId)!.release();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    _circles.remove(event.pointerId)!.cancel();
  }
}
