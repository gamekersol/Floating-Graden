import 'package:flutter/material.dart';

class Currency {
  int value = 999;
  String iconName;

  Currency(this.iconName);
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

  void change (TypeOfCurrency name, int diff){
    if (values[name]!.value + diff < 0) return;

    values[name]!.value += diff;
    notifyListeners();
    print('notify listeners');
  }
}

Currencys currencys = Currencys();