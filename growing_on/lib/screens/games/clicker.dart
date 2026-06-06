import 'package:flutter/material.dart';

int _requiredClicks = 5;
int _cost = 1;
late ValueNotifier<int> _counter;
class ClickerGame extends StatelessWidget {

  ClickerGame({super.key}) {
    _counter = ValueNotifier(_requiredClicks);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 0, vertical: 100),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          // MAIN CLICK CIRCLE
          clickCircle(),

          // UPGRADE OPTIONS
        ],
      ),
    );
  }

  Widget clickCircle() =>
  GestureDetector(
    onTap: () => _counter.value -= _cost,
    child: ListenableBuilder(
      listenable: _counter,
      builder: (context, child) => Container(
        width: 400,
        height: 400,
        decoration: ShapeDecoration(
          shape: CircleBorder()
        ),
        child: Text('${_counter.value}'),
      ),
    ),
  );
}