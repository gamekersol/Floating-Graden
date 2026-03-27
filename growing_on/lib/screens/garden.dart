import 'package:flutter/material.dart';

class GardenScreen extends StatelessWidget {
  const GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      garden(),
      _ui(),
      ]
    );
  }

  Widget _ui (){
    return Align(
      alignment: Alignment(0.8, 0.6),
      child: ElevatedButton(onPressed: ()=>print("pressed"), child: Icon(Icons.add),));
  }

  Widget garden (){
    return Container(color: Colors.amber, width : 50, height : 50);
  }
}