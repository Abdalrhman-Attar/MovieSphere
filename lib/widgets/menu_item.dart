import 'package:flutter/material.dart';
import 'package:movie_sphere/module/dynamic_icon_viewer.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.child,
    this.press,
  });

  final String text;
  final String icon;
  final Widget child;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                DynamicIconViewer(
                  filePath: icon,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 20),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const Spacer(),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
