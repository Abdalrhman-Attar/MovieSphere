import 'package:flutter/material.dart';

Widget globalIconButton({
  required Function() function,
  required IconData icon,
  required Color color,
}) {
  return IconButton(
    onPressed: function,
    icon: Icon(
      icon,
      color: color,
      size: 30,
    ),
  );
}
