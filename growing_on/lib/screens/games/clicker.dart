import 'package:flutter/material.dart';
import '../../data/currency.dart';

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
        spacing: 30,
        children: [
          // MAIN CLICK CIRCLE
          Center(child: clickCircle()),

          // UPGRADE OPTIONS

        ],
      ),
    );
  }

  Widget clickCircle() =>
  GestureDetector(
    onTap: () => countDown(),
    child: ListenableBuilder(
      listenable: _counter,
      builder: (context, child) => Container(
        alignment: .center,
        width: 250,
        height: 250,
        decoration: ShapeDecoration(
          color: Colors.amber[100],
          shape: CircleBorder(side: BorderSide(color: Colors.yellow, width: 10))
        ),
        child: Text('${_counter.value}', textAlign: .center, style: TextStyle(fontSize: 65),),
      ),
    ),
  );
}

void countDown(){
  if (_counter.value - _cost <=0){
    // get seed pal
    currencys.change(.seeds, _cost);
    _counter.value = _requiredClicks;
  }
  else _counter.value -= _cost;
}