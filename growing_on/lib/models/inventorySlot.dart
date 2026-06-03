import 'package:flutter/material.dart';
import 'package:growing_on/theme.dart';

import 'item.dart';
export 'item.dart';

// а чи перебудуєтьс дочірній якщо від зберігався у змінній

class CellContent extends StatelessWidget{
  final ValueNotifier <Item?> item = ValueNotifier(null);
  int count;

  CellContent ({super.key ,Item? value, this.count = 1}){
    item.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder (
      valueListenable: item,
      // ITEM ICON
      builder: (context, value, child) =>
        item.value != null ? Padding(
          padding: EdgeInsetsGeometry.all(0),
          child: Center(
            child: item.value!.getImage(),
          )
        ) : SizedBox.shrink(),
    );
  }
}
