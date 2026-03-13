import 'package:flutter/material.dart';

class ActiveTagsBar extends StatelessWidget {
  const ActiveTagsBar({
    super.key,
    required this.activeTags,
    required this.onRemove,
  });

  final Set<String> activeTags;
  final void Function(String tag) onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: activeTags
            .map(
              (tag) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InputChip(
                  label: Text('#$tag'),
                  onDeleted: () => onRemove(tag),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
