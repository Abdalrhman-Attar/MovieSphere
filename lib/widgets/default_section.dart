import 'package:flutter/material.dart';
import 'package:movie_sphere/module/buttons/text_icon_button.dart';

class DefaultSection extends StatelessWidget {
  const DefaultSection({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonFunction,
    required this.child,
  });

  final String title;
  final String description;
  final String buttonText;
  final Function buttonFunction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 30,
                      child: globalTextIconButton(
                        function: () => buttonFunction(),
                        label: buttonText,
                        textColor: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                        letterSpacing: 1.5,
                        icon: Icons.arrow_forward_ios_rounded,
                        iconSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          child,
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
