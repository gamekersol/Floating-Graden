import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../main.dart' as main;
import '../panels/itemInfoOverlay.dart' as infoOverlay;
import '../panels/plantsPlacingOverlay.dart' as placingOverlay;
import '../models/plant.dart';

class Item 
{
  final String name;
  final String description;
  final String imagePath;

  const Item({required this.name, required this.imagePath, this.description = ''});

  Widget getImage() => SvgPicture.asset(imagePath, fit: .contain,);
  void use() => print('noneuse');
}

class SeedItem extends Item{
  final Species species;

  const SeedItem({
    required super.name,
    required super.imagePath,
    required this.species,
    super.description,
  });

  @override
  void use() {
    infoOverlay.isEnabled.value = false;
    main.GoToPage(1);

    Timer(Duration(milliseconds: 300), (){
      placingOverlay.handlingPlant = Plant(species: species)..stage = species.stages.length;
      placingOverlay.isEnabled.value = true;
    });
  }
}