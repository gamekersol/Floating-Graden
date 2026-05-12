import 'package:flutter/material.dart';

ValueNotifier <bool> isEnabled = ValueNotifier(false);

class ItemInfoOverlay extends StatefulWidget {
  const ItemInfoOverlay({super.key});

  @override
  State<ItemInfoOverlay> createState() => _ItemInfoOverlayState();
}

class _ItemInfoOverlayState extends State<ItemInfoOverlay> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: isEnabled,
      builder: (context, child) => 
      AnimatedOpacity(
        opacity: isEnabled.value == false ? 0 : 1,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: IgnorePointer(
          ignoring: !isEnabled.value,
          child: dumbWidget(),
        ),
      )
    );
  }

  Widget dumbWidget(){
    return SafeArea(
      child: GestureDetector(
        onTap: () => isEnabled.value = false,
      ),
    );
  }
}