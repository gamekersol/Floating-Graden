import 'package:flutter/material.dart';

import 'games/tetris.dart';
import  'games/clicker.dart';


final ValueNotifier<int> screenIndex = ValueNotifier(0);
const Duration TRANSIDION_DURATION = Duration(milliseconds: 500);

class GamesScreen extends StatefulWidget {
  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Stack(
        children: [
          Screen(gameWidget: mainScreen(), index: 0),
          //Screen(gameWidget: Tetris(), index: 1),
          Screen(gameWidget: ClickerGame(), index: 2),
        ]
      )
    );
  }
}

const ButtonStyle _buttonStyle = ButtonStyle(
  iconSize: WidgetStatePropertyAll(70),
);

Widget mainScreen () =>  Padding(
  padding: const EdgeInsets.fromLTRB(17,90,17,65),
  child: 
  Row(
    spacing: 20,
    children: [
      GameButton(name: 'Tetris', index : 1,),
      GameButton(name: 'Clicker', index: 2,),
    ],
  ),
);

class GameButton extends StatelessWidget {
  final int index;
  final String name;

  GameButton({super.key, required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _buttonStyle,
      onPressed: () => screenIndex.value = index,
      child: Text(name)
    );
  }
}

class Screen extends StatelessWidget {
  final Widget gameWidget;
  final int index;
  const Screen({super.key, required this.gameWidget, required this.index});

  @override
  Widget build(BuildContext context) =>
    ListenableBuilder(
      listenable: screenIndex,
      builder: (context, child) => AnimatedOpacity(
        duration: TRANSIDION_DURATION,
        opacity: screenIndex.value == index ? 1 : 0,
        child: gameWidget,
      ),
    );
}