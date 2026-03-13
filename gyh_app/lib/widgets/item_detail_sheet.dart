import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/inventory_item.dart';
import '../utils/rarity_utils.dart';

void showItemDetail(BuildContext context, InventoryItem item) {
  final color = rarityColor(item.rarity);

  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SvgPicture.asset(item.iconPath, width: 72, height: 72),
          const SizedBox(height: 12),
          Text(
            item.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          // Rarity badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color),
            ),
            child: Text(
              rarityLabel(item.rarity),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: item.tags
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '#$tag',
                      style:
                          const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 14),
          if (item.description.isNotEmpty)
            Text(
              item.description,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey),
            ),
          const SizedBox(height: 12),
          QuantityBar(item: item, rarityColor: color),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                //width: double.infinity,
                child: FilledButton(
                  style: ButtonStyle(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                    item.onUse(item);
                  },
                  child: const Text('Destroy'),
                ),
              ),
              SizedBox(
                //width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    item.onUse(item);
                  },
                  child: const Text('Use'),
                ),
              ),
            ]
          )
        ],
      ),
    ),
  );
}

class QuantityBar extends StatelessWidget {
  const QuantityBar({
    super.key,
    required this.item,
    required this.rarityColor,
  });

  final InventoryItem item;
  final Color rarityColor;

  @override
  Widget build(BuildContext context) {
    final ratio = (item.quantity / item.maxQuantity).clamp(0.0, 1.0);
    final isFull = item.quantity >= item.maxQuantity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quantity',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.grey),
            ),
            Text(
              '${item.quantity} / ${item.maxQuantity}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isFull ? Colors.amber.shade700 : null,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 8,
            backgroundColor: rarityColor.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation(
                isFull ? Colors.amber.shade600 : rarityColor),
          ),
        ),
      ],
    );
  }
}
