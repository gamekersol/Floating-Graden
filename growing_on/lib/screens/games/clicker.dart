import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
          upgradeOptionWidget('Clicks', _requiredClicks, 5 * (6 - _requiredClicks)),
         // SizedBox(height: 10),
          upgradeOptionWidget('Cost', _cost, _cost * 20),
        ],
      ),
    );
  }

  Widget clickCircle() =>
  GestureDetector(
    onTap: () => countDown(),
    child: ListenableBuilder(
      listenable: _counter,
      builder: (context, child) => AnimatedContainer(
        duration: Duration(milliseconds: 150),
        alignment: .center,
        margin: .all((150 - 150 / _counter.value)/2),
        width: 100 + 150 / _counter.value,
        height: 100 + 150 / _counter.value,
        decoration: ShapeDecoration(
          color: Colors.amber[100],
          shape: CircleBorder(side: BorderSide(color: Colors.yellow, width: 10))
        ),
        child: Text('${_counter.value}', textAlign: .center, style: TextStyle(fontSize: 65),),
      ),
    ),
  );

  Widget upgradeOptionWidget(String paramName, Object value, int cost){
    return Expanded(
      flex: 1,
      child: Row(
        children:[ 
          // PARAM NAME
          Expanded(
            flex: 3,
            child: Container(
              height: 45,
              //margin: .symmetric(vertical: 15),
              padding: .symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(30)
              ),
              child: Text(
                paramName,
                textAlign: .left,
                style: TextStyle(
                  color: Color(0xFF5D8D69),
                  fontWeight: .w600
              ),
              ),
            ),
          ),

          // PARAM VALUE
          Expanded(
            flex: 1,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(60),
                borderRadius: .circular(10),
              ),
              child: Text(
                value.toString(),
                textAlign: .center,
              ),
            ),
          ),

          // UPGRADE MUTTON
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () => currencys.change(.diamonds, -cost),
              icon: Container(
                //padding: .all(50),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(50),
                  borderRadius: .circular(25),
                ),
                child: Row(
                  mainAxisAlignment: .center,
                  spacing: 10,
                  children: [
                    AutoSizeText(cost.toString()),
                    SizedBox.square(dimension:  50, child: currencys.values[TypeOfCurrency.diamonds]!.getImage()),
                  ],
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}

void countDown(){
  if (_counter.value - _cost <=0){
    // get seed pal
    currencys.change(.seeds, _cost);
    _counter.value = _requiredClicks;
  }
  else _counter.value -= _cost;
}