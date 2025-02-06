import 'package:flutter/material.dart';

Widget globalTextIconButton({
  required Function() function,
  required String label,
  required Color textColor,
  required double fontSize,
  required double letterSpacing,
  required IconData icon,
  required double iconSize,
}) {
  return TextButton(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    ),
    onPressed: function,
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w100,
            letterSpacing: letterSpacing,
          ),
        ),
        const SizedBox(width: 5),
        Icon(
          icon,
          color: textColor,
          size: iconSize,
        ),
      ],
    ),
  );
}
