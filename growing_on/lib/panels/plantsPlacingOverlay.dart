
import 'package:flutter/material.dart';
import '../data/garden.dart';
import '../screens/garden.dart';

class _MovingBlocksOverlayState extends StatefulWidget {
  late ValueNotifier <bool> isEnabled;

  _MovingBlocksOverlayState({super.key});

  @override
  State<_MovingBlocksOverlayState> createState() => __MovingBlocksOverlayStateState();
}

class __MovingBlocksOverlayStateState extends State<_MovingBlocksOverlayState> {
  @override
  Widget build(BuildContext context) {
    var isEnabled = widget.isEnabled.value;
    return ListenableBuilder(
      listenable: widget.isEnabled,
      builder: (context,child) {
        return AnimatedOpacity(
          opacity: isEnabled == false ? 0 : 1,
          duration: Duration(milliseconds: 2000),
          curve: Curves.easeIn,
          child: IgnorePointer(
            ignoring: !isEnabled,
            child: dumbWidget(),
          ),
        );
      },
    );
  }

  Widget dumbWidget(){
    return SafeArea(
      child: SafeArea(
        child: DecoratedBox(
          // Black tint
          decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
          child: Stack(
            children: [
              // Arrows
              Icon(Icons.moving_rounded, size: 200,),
              // Phantom Plant
              phantomPalnt(),
            ],
          ),
        ),
      )
    );
  }

  Widget phantomPalnt(){
    return Align(
      
    );
  }
}