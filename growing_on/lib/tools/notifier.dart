import 'package:flutter/material.dart';

class ForceNotifier<T> extends ValueNotifier<T> {
  ForceNotifier(super.value);
  void notify() => notifyListeners();
}