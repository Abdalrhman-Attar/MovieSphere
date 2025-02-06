import 'package:flutter/material.dart';
import 'package:movie_sphere/module/dynamic_icon_viewer.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.isSelected,
    required this.label,
    required this.index,
    required this.onItemTapped,
  });

  final String icon;
  final String activeIcon;
  final bool isSelected;
  final String label;
  final int index;
  final void Function(int)? onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          onItemTapped?.call(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DynamicIconViewer(
              filePath: isSelected ? activeIcon : icon,
              size: 28,
              color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
