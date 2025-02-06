import 'package:flutter/material.dart';

Widget globalElevatedButton({
  required Color backgroundColor,
  required Color textColor,
  required bool isLoading,
  required Function() function,
  required BuildContext context,
  required String label,
  double? fontSize,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 45,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        elevation: 0,
      ),
      onPressed: function,
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.onSurface,
              ),
            )
          : Text(
              label,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: textColor,
                    fontSize: fontSize ?? 16,
                  ),
            ),
    ),
  );
}
