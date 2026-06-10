import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/currency.dart';

//var prefs = SharedPreferencesAsync();
late SharedPreferences prefs;

Future<void> _buy (String paramName, ValueNotifier<int> notifier, int cost, {int upgradeValue = 1}) async{
  if (!currencys.change(.diamonds, -cost)) return;
  
  notifier.value += upgradeValue;
  await prefs.setInt(paramName, notifier.value);
}

class ClickerGame extends StatefulWidget {

  @override
  State<ClickerGame> createState() => _ClickerGameState();

}

class _ClickerGameState extends State<ClickerGame> {

  late ValueNotifier<int> _counter;

  // PARAMETERS
  final ValueNotifier<int> _requiredClicks = ValueNotifier(5);
  final ValueNotifier<int> _cost = ValueNotifier(1);

  Future <void> _getSaves() async{
    _requiredClicks.value = await prefs.getInt("Clicks") ?? 5;
    _cost.value = await prefs.getInt("Cost") ?? 1;

    _counter.value = _requiredClicks.value;
  }

  void _countDown(){
    if (_counter.value - _cost.value <= 0){
      // get seed pal
      currencys.change(.seeds, _cost.value);
      _counter.value = _requiredClicks.value;
    }
    else _counter.value -= _cost.value;
  }

  @override
  void initState() {
    super.initState();
    _counter = ValueNotifier(_requiredClicks.value);
    SharedPreferences.getInstance().then((p) {
      prefs = p;
      _getSaves();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 0, vertical: 100),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .start,
        spacing: 30,
        children: [
          // MAIN CLICK CIRCLE
          Center(child: clickCircle()),

          // UPGRADE OPTIONS
          upgradeOptionWidget('Clicks', _requiredClicks, () => 5 * (6 - _requiredClicks.value), upgradeValue: -1),
          upgradeOptionWidget('Cost', _cost, () => _cost.value * 20),
        ],
      ),
    );
  }

  Widget clickCircle() =>
  GestureDetector(
    onTap: () => _countDown(),
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

  Widget upgradeOptionWidget(String paramName, ValueNotifier<int> notifier,int Function() cost, {int upgradeValue = 1}){
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) => Row(
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
                notifier.value.toString(),
                textAlign: .center,
              ),
            ),
          ),
      
          // UPGRADE BUTTON
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () => _buy(paramName, notifier, cost(), upgradeValue: upgradeValue),
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(50),
                  borderRadius: .circular(25),
                ),
                child: Row(
                  mainAxisAlignment: .center,
                  spacing: 10,
                  children: [
                    AutoSizeText(cost().toString()),
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


