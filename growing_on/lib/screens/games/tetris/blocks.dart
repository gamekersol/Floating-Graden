import 'dart:math';
import 'package:flutter/material.dart';

List<Block> buffer = [
  Block(form: forms[Random().nextInt(forms.length)])
];

class Block{
  List<int> form;
  Color color = const Color.fromARGB(255, 173, 20, 20);
  int x = 4, y = 5;

  Block({required this.form});

  void rotate() {
    List<int> newForm = List.filled(9, 0);
    for (int i = 0; i < 9; i++) {
      int x = i % 3 - 1;
      int y = i ~/ 3 - 1;
      int newX = -y + 1;
      int newY = x + 1;
      newForm[newX + newY * 3] = form[i];
    }
    form = newForm;
  }
}

List<List<int>> forms = [
  [ // I
    0,1,0,
    0,1,0,
    0,1,0,
  ],
  [ // O
    0,0,0,
    0,1,1,
    0,1,1,
  ],
  [ // T
    0,1,0,
    1,1,0,
    0,1,0,
  ],
  [ // L
    0,1,1,
    0,1,0,
    0,1,0,
  ],
  [ // N
    0,1,1,
    1,1,0,
    0,0,0,
  ],
];