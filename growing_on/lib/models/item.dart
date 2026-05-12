import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Item 
{
  final String name;
  final String description;
  final String imagePath;

  const Item({required this.name, required this.imagePath, this.description = ''});

  Widget getImage() => SvgPicture.asset(imagePath, fit: .contain,);
}