import 'dart:async';

import 'package:flutter/material.dart';
import 'tetris/blocks.dart';

const int _WIDTH = 10, _HEIGHT = 20;
const Duration frameDelta = Duration(milliseconds: 400);

class Tetris extends StatelessWidget {
  const Tetris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
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
    Timer.periodic(frameDelta, _Tick);
  }

  void _Tick(Timer timer){
    setState(() {
      fieldData = List.filled(_WIDTH*_HEIGHT, Point(const Color.fromARGB(255, 0, 33, 37)));

      // move
      buffer[0].rotate();

      // render objs
      for (Block block in buffer){
        for (int i = 0; i < block.form.length; i++) {
          if (block.form[i]==0) continue;
          int x = i % 3 - 1;
          int y = i ~/ 3 - 1;
          var point = fieldData[((y + block.y) * _WIDTH) + (x + block.x)];
          point.color = block.color;
        }
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }
}

List<Point> fieldData = List.generate(
  _WIDTH * _HEIGHT, 
  (_) => Point(const Color.fromARGB(255, 0, 33, 37)),
);

class Point{
  Color color;

  Point(this.color);
}
class PointWidget extends StatelessWidget {
  final Point data;
  const PointWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: data.color,
      ),
    );
  }
}