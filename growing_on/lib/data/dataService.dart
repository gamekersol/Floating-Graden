import 'dart:math';
import 'package:growing_on/tools/jsonStorage.dart';
import 'garden.dart' as garden;
//import 'currency.dart';

Future <void> Load() async {

  var rawBlockData = await JsonStorage.load('garden');
  
  garden.initData(rawBlockData);

  if (rawBlockData.length == 0) _onFirstLaunch();
}

void _onFirstLaunch(){
  garden.addBlock(Point(0, 0));
}