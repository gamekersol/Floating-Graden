import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/inventory_item.dart';
import '../app/theme.dart';
import 'item_detail_sheet.dart';

class InventoryBox extends StatelessWidget {
  const InventoryBox({super.key, required this.items});

  final List<InventoryItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFC29B65),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 8,
              blurRadius: 0,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            childAspectRatio: 1.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) => ItemCard(item: items[index]),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});

  final InventoryItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showItemDetail(context, item),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The 3D Base/Shadow
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.only(top: 8),
          ),
          // The Main Card
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFD2AF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  item.iconPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Quantity Badge (Bottom Right)
          Positioned(
            right: -4,
            bottom: 4,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.primaryLighter,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(2, 2),
                    blurRadius: 0,
                  ),
                ],
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Center(
                child: Text(
                  item.quantity.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
