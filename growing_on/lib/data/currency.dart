import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _ASSET_PATH = 'assets/images/trinckets/';

class Currency {
  int value = 404;
  String iconName;

  Currency(this.iconName);

  Widget getImage ()=> SvgPicture.asset(_ASSET_PATH + iconName.toString(), fit: .contain,);
}

Currency _seeds = Currency('seed.svg');
Currency _coins = Currency('coin.svg');
Currency _diamonds = Currency('diamond.svg');

enum TypeOfCurrency {seeds, coins , diamonds}

class Currencys extends ChangeNotifier{

  final Map <TypeOfCurrency,Currency> values = {
    .seeds : _seeds ,
    .coins : _coins , 
    .diamonds : _diamonds ,
  };

  bool change (TypeOfCurrency name, int diff) {
    var value = values[name]!.value;

    if (value + diff < 0) return false;
    value += diff;
    notifyListeners();
    save(name, value);
    
    return true;
  }

  Future <void> save(TypeOfCurrency name, int value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(name.toString(), value);
  }
}

void setValues(int seeds, int coins, int diamonds){
  _seeds.value = seeds;
  _coins.value = coins;
  _diamonds.value = diamonds;
}

Currencys currencys = Currencys();