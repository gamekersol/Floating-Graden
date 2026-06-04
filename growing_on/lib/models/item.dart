import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../main.dart' as main;
import '../panels/itemInfoOverlay.dart' as infoOverlay;
import '../panels/plantsPlacingOverlay.dart' as placingOverlay;
import '../data/currency.dart';
import '../models/plant.dart';
import '../data/inventory.dart' as inv;

enum Rarity{
  common,
  uncommon,
  rare,
  veryrare,
  divided,
  vanished,
  mythical,
  forgoten,
  theonlyone
}

class Item 
{
  final String name;
  final String description;
  final String imagePath;
  final Rarity rarity;

  const Item({required this.name, this.rarity = .common, required this.imagePath, this.description = ''});

  Widget getImage() => SvgPicture.asset(imagePath, fit: .contain,);
  void use() => print('noneuse');

}

class CurrencyContainer extends Item{
  final TypeOfCurrency type;
  final int count;

  const CurrencyContainer({
    required super.name,
    super.rarity = .common,
    required super.imagePath,
    required this.type,
    required this.count,
    super.description,
  });

  @override
  void use() {
    currencys.change(type, count);
    inv.instance.remove(this, 1);
    infoOverlay.isEnabled.value = false;
  }
}

class SeedItem extends Item{
  final Species species;

  const SeedItem({
    required super.name,
    super.rarity = .common,
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

  static const String _ASSEST_PATH = "assets/images/plants/";

  @override
  Widget getImage() {
    return Stack(
      children: [
        Positioned.fill(child: SvgPicture.asset(imagePath, fit: .contain)),
        Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset(
            _ASSEST_PATH + species.name + "Icon.svg",
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}