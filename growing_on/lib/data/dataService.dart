import 'dart:math';
import 'package:growing_on/tools/jsonStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'garden.dart' as garden;
import 'currency.dart' as currencys;

Future <void> Load() async {

  var rawBlockData = await JsonStorage.load('garden');
  garden.initData(rawBlockData);

  final prefs = await SharedPreferences.getInstance();
  currencys.setValues(prefs.getInt('seeds') ?? 50, prefs.getInt('coins') ?? 0, prefs.getInt('diamonds') ?? 0);

  if (rawBlockData.length == 0) _onFirstLaunch();
}

void _onFirstLaunch(){
  garden.addBlock(Point(0, 0));
}