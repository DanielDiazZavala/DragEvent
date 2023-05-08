import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:figuras_flame/figures.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flame/components.dart';

import 'tap_button.dart';
var incremento = 0;

class MyGame extends FlameGame with KeyboardEvents {
  bool get debug => true;
  late ZonaDrag zona;

  final sizeOfPlayer = Vector2(80, 100);

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 200, 200, 200);
  }

  @override
  void render(Canvas canvas) {
    final Flower flower = children.query<Flower>().first;
    flower.position = Vector2(flower.position.x, size.y - sizeOfPlayer.y);
    super.render(canvas);
  }

  @override
  Future<void> onLoad() async {
    
    children.register<Flower>();
    await add(Flower(
      position: Vector2(size.x / 2, size.y - sizeOfPlayer.y),
      paint: Paint()..color = Colors.pink,
      size: sizeOfPlayer,
    ));
     //butones de las esquinas 
    await add(TapButton()
      ..position = Vector2(size.x - 50, 75)
      ..size = Vector2(100, 100));
    await add(TapButton()
      ..position = Vector2(50, 75)
      ..size = Vector2(100, 100));

 //definicion de tamaño de la zona
    zona = ZonaDrag(
      n: 3,
      size: Vector2(1600,120),
      color: const Color(0xff6ecbe5),
      position: Vector2(0, 565),
    );
    await add(zona);
    
  }
//actualizacion de la pantalla
  @override
  void update(double dt) {
    if (children.isNotEmpty) {
      final Flower flower = children.query<Flower>().first;
      flower.position.x += incremento * dt;
      if (flower.position.x > size.x) {
      flower.position.x = -flower.size.x;
    }
     if (flower.position.x + flower.width < 0) {
      flower.position.x = size.x;
     
    }
    }

    super.update(dt);
  }
  
//evento teclado
  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        moverIzquierda();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        moverDerecha();
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void moverIzquierda() {
    final Flower flower = children.query<Flower>().first;
    flower.position.x -= 8;
    if (flower.position.x + flower.width < 0) {
      flower.position.x = size.x;
    }
  }

  mover() {
    final Flower flower = children.query<Flower>().first;
    flower.position.x -= 8;
  }

  void moverDerecha() {
    final Flower flower = children.query<Flower>().first;
    flower.position.x += 8;
    if (flower.position.x > size.x) {
      flower.position.x = -flower.size.x;
    }
  }
}
//Evento DRAG
class ZonaDrag extends PositionComponent with DragCallbacks {
  ZonaDrag({
    required int n,
    required super.size,
    required this.color,
    super.position,
  }) {
    zonaRectangulo = 
    Path()
      ..moveTo(0, 0)
      ..lineTo(size.x , 0)
      ..lineTo(size.x , size.y )
      ..lineTo(0, size.y)
    ..close();
  }

  final Color color;
  final Paint colorRectangulo = Paint();
  final Paint colorBorde = Paint()
    ..color = const Color(0xFFffffff)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  final _shadowPaint = Paint()
    ..color = const Color(0xFF000000)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
  late final Path zonaRectangulo;
  bool _isDragged = false;

  @override
  bool containsLocalPoint(Vector2 point) {
    return zonaRectangulo.contains(point.toOffset());
  }

  @override
  void render(Canvas canvas) {
   
      colorRectangulo.color = color.withOpacity(0.1);
      canvas.drawPath(zonaRectangulo, colorRectangulo);
      canvas.drawPath(zonaRectangulo, colorBorde);
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _isDragged = true;
    
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragged = false;
    incremento= 0; //agregar un + para q no se pare en seco
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final delta = event.delta;
   
    if ((delta.x > 0)) {
      incremento+= 3;
    } else if(delta.x < 0) {
      incremento-= 3;
    }
  }

}



