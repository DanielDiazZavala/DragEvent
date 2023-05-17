import 'dart:async';

import 'dart:html';
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
int puntaje=0;
  int score=0;
  double vel=.5;
  double GenerarFigura=3;
  double TiempoGenerarFigura=0;
  int vidas=6;
  late final Flower player;

class MyGame extends FlameGame with KeyboardEvents {
  bool get debug => true;
  late ZonaDrag zona;

  final sizeOfPlayer = Vector2(80, 100);

  @override
  Color backgroundColor() {
    return Color.fromARGB(255, 12, 244, 240);
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

    player=Flower(
      position: Vector2(size.x / 2, size.y - sizeOfPlayer.y),
      paint: Paint()..color = Colors.pink,
      size: sizeOfPlayer,
    );

    await add(player);
     //butones de las esquinas 
  /*  await add(TapButton()
      ..position = Vector2(size.x - 50, 75)
      ..size = Vector2(100, 100));
    await add(TapButton()
      ..position = Vector2(50, 75)
      ..size = Vector2(100, 100));
*/
 //definicion de tamaño de la zona
    zona = ZonaDrag(
      n: 3,
      size: Vector2(1600,250),
      color: Color.fromARGB(255, 168, 133, 208),
      position: Vector2(0, 555),
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
     if(vidas>0){

    TiempoGenerarFigura+=dt;
    if(TiempoGenerarFigura>GenerarFigura){
      var PosicionRamdom=Random();
      var   FiguraRamdom=Random();
      var TamanoRamdom=Random();

      switch( FiguraRamdom.nextInt(5)){
        case 0:
          add(Grillo(position: Vector2(PosicionRamdom.nextDouble()*(size.x-140),-80), size: Vector2(TamanoRamdom.nextDouble()*140,80), paint: Paint()..color = Colors.green) );
          break;
        case 1:
          add(Pinguino(position: Vector2(PosicionRamdom.nextDouble()*(size.x-40),-80), size: Vector2(TamanoRamdom.nextDouble()*40,80), paint: Paint()..color = Colors.grey) );
          break;
        case 2:
          add(Caballito(position: Vector2(PosicionRamdom.nextDouble()*(size.x-40),-80), size: Vector2(TamanoRamdom.nextDouble()*40,80), paint: Paint()..color = Colors.brown) );
          break;
        case 3:
          add(Libreta(position: Vector2(PosicionRamdom.nextDouble()*(size.x-40),-80), size: Vector2(TamanoRamdom.nextDouble()*40,80), paint: Paint()..color = Colors.pink) );
          break;
        case 4:
          add(Elefante(position: Vector2(PosicionRamdom.nextDouble()*(size.x-120),-80), size: Vector2(TamanoRamdom.nextDouble()*120,80), paint: Paint()..color = Colors.blue) );
          break;
      }
      if(score%5==0){
      vel+=.2;
      GenerarFigura*=.9;
      }

      //add(Pinguino(position: Vector2(PosicionRamdom.nextDouble()*(size.x-40),-80), size: Vector2(40,80), paint: Paint()..color = Colors.pink) );
      TiempoGenerarFigura=0;
    }

    bool GriloColision(Flower player, Grillo figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    bool PinguinoColision(Flower player, Pinguino figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    bool CaballoColision(Flower player, Caballito figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    bool StickmanColision(Flower player, Stickman figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    bool BallenaColision(Flower player, Ballena figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    bool LibretaColision(Flower player, Libreta figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    for(var text in children.query<TextComponent>()){
      children.remove(text);
    }
    add(TextComponent(
         priority: 100,
         text: score.toString(),
         position: Vector2(850, 80),
         size: Vector2(350, 300),
       ),);
    
    add(TextComponent(
         priority: 100,
         text: "Vidas:"+vidas.toString(),
         position: Vector2(850, 50),
         size: Vector2(150, 100),
       ));

    for (var figura in children.query<Grillo>()) {
      if (GriloColision(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
          vidas--;
        }
      }
    }

    for (var figura in children.query<Pinguino>()) {
      if (PinguinoColision(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
          vidas--;
        }
      }
    }

    for (var figura in children.query<Caballito>()) {
      if (CaballoColision(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
          vidas--;
        }
   }
    }

    for (var figura in children.query<Ballena>()) {
      if (BallenaColision(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
          vidas--;
        }
      }
    }

    for (var figura in children.query<Libreta>()) {
      if (LibretaColision(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
          vidas--;
        }
      }
    }

    for (var figura in children.query<Stickman>()) {
      if (StickmanColision(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
          vidas--;
        }
      }
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
    ..color = Color.fromARGB(255, 197, 41, 41)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  final _shadowPaint = Paint()
    ..color = Color.fromARGB(255, 205, 32, 32)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
  late final Path zonaRectangulo;
  bool _isDragged = false;

  @override
  bool containsLocalPoint(Vector2 point) {
    return zonaRectangulo.contains(point.toOffset());
  }

  @override
  void render(Canvas canvas) {
   
      colorRectangulo.color = color.withOpacity(0.4);
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
      incremento+= 10;
    } else if(delta.x < 0) {
      incremento-= 10;
    }
  }

}



