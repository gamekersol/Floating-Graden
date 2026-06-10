import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/currency.dart';


late ValueNotifier<int> _counter;
var prefs = SharedPreferencesAsync();

final ValueNotifier<int> _requiredClicks = ValueNotifier(5);
final ValueNotifier<int> _cost = ValueNotifier(1);

Future <void> _getSaves() async{
  _requiredClicks.value = await prefs.getInt("Clicks") ?? 5;
  _cost.value = await prefs.getInt("Cost") ?? 1;

  _counter.value = _requiredClicks.value;
}

class ClickerGame extends StatefulWidget {

  @override
  State<ClickerGame> createState() => _ClickerGameState();
}

class _ClickerGameState extends State<ClickerGame> {

  @override
  void initState() {
    super.initState();
    _counter = ValueNotifier(_requiredClicks.value);
    _getSaves(); // для initState це нормально, але треба перевірити порядок нижче
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
          ListenableBuilder(
            listenable: _requiredClicks,
            builder: (context, child) => upgradeOptionWidget('Clicks', _requiredClicks.value, 5 * (6 - _requiredClicks.value), change: -1)
          ),
         // SizedBox(height: 10),
          ListenableBuilder(
            listenable: _cost,
            builder: (context, child) => upgradeOptionWidget('Cost', _cost.value, _cost.value * 20)
          ),
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

  Widget upgradeOptionWidget(String paramName, int value, int cost, {int change = 1}){
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
              onPressed: () {
                //SetState
                _buy(paramName, value, cost, change: change);
              },
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

  Future<void> _buy (String paramName, int value, int cost, {int change = 1}) async{
    if (!currencys.change(.diamonds, -cost)) return;

    switch (paramName) {
      case 'Clicks':
        _requiredClicks.value += change;
        await prefs.setInt(paramName, _requiredClicks.value);
      case 'Cost':
        _cost.value += change;
        await prefs.setInt(paramName, _cost.value);
    }
  }

  void countDown(){
    if (_counter.value - _cost.value <=0){
      // get seed pal
      currencys.change(.seeds, _cost.value);
      _counter.value = _requiredClicks.value;
    }
    else _counter.value -= _cost.value;
  }
}


