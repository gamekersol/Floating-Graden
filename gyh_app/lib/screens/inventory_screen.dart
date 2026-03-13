import 'package:flutter/material.dart';

import '../data/mock_inventory.dart';
import '../models/inventory_item.dart';
import '../widgets/active_tags_bar.dart';
import '../widgets/inventory_box.dart';
import '../widgets/inventory_empty_state.dart';
import '../widgets/inventory_header.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final Set<String> _activeTags = {};

  // Collect all unique tags from items, sorted alphabetically
  List<String> get _allTags {
    final tags = <String>{};
    for (final item in mockInventoryItems) {
      tags.addAll(item.tags);
    }
    return tags.toList()..sort();
  }

  List<InventoryItem> get _filteredItems {
    if (_activeTags.isEmpty) return mockInventoryItems;
    return mockInventoryItems
        .where((item) => _activeTags.every((tag) => item.tags.contains(tag)))
        .toList();
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_activeTags.contains(tag)) {
        _activeTags.remove(tag);
      } else {
        _activeTags.add(tag);
      }
    });
  }

  void _showSortMenu(BuildContext buttonContext) {
    final RenderBox button =
        buttonContext.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(buttonContext).overlay!.context.findRenderObject()
            as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
            button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: buttonContext,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      items: [
        PopupMenuItem(
          value: '__clear__',
          child: Row(
            children: const [
              Icon(Icons.clear_all, size: 18),
              SizedBox(width: 10),
              Text('Clear all filters'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        ..._allTags.map(
          (tag) => PopupMenuItem(
            value: tag,
            child: Row(
              children: [
                Icon(
                  _activeTags.contains(tag)
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  size: 18,
                  color: _activeTags.contains(tag)
                      ? Theme.of(buttonContext).colorScheme.primary
                      : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text('#$tag'),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value == null) return;
      if (value == '__clear__') {
        setState(() => _activeTags.clear());
      } else {
        _toggleTag(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InventoryHeader(
          itemCount: mockInventoryItems.length,
          activeTagCount: _activeTags.length,
          onSortTap: _showSortMenu,
        ),
        if (_activeTags.isNotEmpty)
          ActiveTagsBar(
            activeTags: _activeTags,
            onRemove: _toggleTag,
          ),
        Expanded(
          child: _filteredItems.isEmpty
              ? const InventoryEmptyState()
              : InventoryBox(items: _filteredItems),
        ),
      ],
    );
  }
}
