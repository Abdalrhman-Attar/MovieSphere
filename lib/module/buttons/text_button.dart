import 'package:flutter/material.dart';

Widget globalTextButton({
  required Function() function,
  required String label,
  required Color textColor,
  required double fontSize,
}) {
  return TextButton(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    ),
    onPressed: function,
    child: Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
