import 'package:flutter/material.dart';

export 'games/tetris.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Padding(
        padding: const EdgeInsets.fromLTRB(17,90,17,65),
        child: 
        Row(
          spacing: 20,
          children: [
            GameButton(name: "Tetris", route: "/Tetris"),
            GameButton(name: "Tetris", route: "/Tetris"),
          ],
        ),
      )
    );
  }
}

const ButtonStyle _buttonStyle = ButtonStyle(
  
);

class GameButton extends StatelessWidget {
  String name,route;

  GameButton({super.key, required this.name, required this.route});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _buttonStyle,
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(name)
    );
  }
}