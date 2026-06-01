import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String _ASSET_PATH = 'assets/images/trinckets/';

class Currency {
  int value = 999;
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


  bool change (TypeOfCurrency name, int diff){
    if (values[name]!.value + diff < 0) return false;

    values[name]!.value += diff;
    notifyListeners();
    print('notify listeners');
    return true;
  }
}

Currencys currencys = Currencys();