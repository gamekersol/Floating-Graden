import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'tetris/blocks.dart';

const int _WIDTH = 10, _HEIGHT = 20;
const Color _FIELD_COLOR = Colors.blueGrey;
double timeScale = 1.0;
ValueNotifier<Block> curControlledBlock = ValueNotifier(buffer[0]);


class Tetris extends StatelessWidget {
  const Tetris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // SCREEN
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > constraints.maxHeight;
                final cellSize = isWide
                    ? constraints.maxHeight / _HEIGHT
                    : constraints.maxWidth / _WIDTH;
              
                return Center(
                  child: SizedBox(
                    width: cellSize * _WIDTH,
                    height: cellSize * _HEIGHT,
                    child: Screen(),
                  ),
                );
              },
            ),
            // DETECTORS
            Expanded(
              child: GestureDetector(
                onTap: () {curControlledBlock.value.rotate(); curControlledBlock.value.rotatedTimes++;}
              )
            )
          ]
        )
      ),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({
    super.key,
  });

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: (400 * timeScale).round()), _Tick);
  }

  void _Tick(Timer timer){
    setState(() {
      fieldData = List.generate(
        _WIDTH * _HEIGHT, 
        (_) => Point(_FIELD_COLOR));
      // Відмальовуємо блоки
      for (Block block in buffer){
        for (int i = 0; i < block.form.length; i++) {
          if (block.form[i] == 0) continue;
          
          int x = i % 3 - 1;
          int y = i ~/ 3 - 1;

          int gridX = x + block.x;
          int gridY = y + block.y;

          // Перевірка, щоб блок не виліз за межі масиву і не викликав помилку
          //if (gridX >= 0 && gridX < _WIDTH && gridY >= 0 && gridY < _HEIGHT) {
            
            // НОВА ФОРМУЛА ТУТ:
          int index = (gridX * _HEIGHT) + gridY;
          
          var point = fieldData[index];
          point.color = block.color;
          //}
        }
      } 
      moveBlock(0,-1);
    });
  }

  void moveBlock(int cx, int cy){
    var block = curControlledBlock.value;

    cy*=-1;

    for (int i = 0; i < block.form.length; i++) {
      if (block.form[i] == 0) continue;

      int futureX = block.x + cx;
      int futureY = block.y + cy;

      int pos = i + futureY + futureX * _HEIGHT;

      if (fieldData[pos].color != _FIELD_COLOR) return;
    }

    // ACTUAL MOVE

    if(cx!=0)curControlledBlock.value.x += cx;
    if(cy!=0)curControlledBlock.value.y += cy;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: curControlledBlock,
      builder: (context, value, child) {
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _HEIGHT,
          ),
          scrollDirection: Axis.horizontal,
          //padding: EdgeInsets.all(10),
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(
            _WIDTH * _HEIGHT,
            (index) => PointWidget(data: fieldData[index]),
          ),
        );
      },
    );
  }
}

List<Point> fieldData = List.generate(
  _WIDTH * _HEIGHT, 
  (_) => Point(_FIELD_COLOR),
);

class Point{
  Color color;

  Point(this.color);
}

class PointWidget extends StatefulWidget {
  final Point data;
  const PointWidget({super.key, required this.data});

  @override
  State<PointWidget> createState() => _PointWidgetState();
}

class _PointWidgetState extends State<PointWidget> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: widget.data.color,
      ),
    );
  }
}