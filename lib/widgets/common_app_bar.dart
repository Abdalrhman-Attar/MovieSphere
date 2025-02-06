import 'package:flutter/material.dart';

AppBar commonAppBar({
  required BuildContext context,
  required Widget title,
  required bool viewButtons,
  required double? leadingWidth,
  Widget? bottom,
}) {
  return AppBar(
    title: title,
    centerTitle: true,
    automaticallyImplyLeading: false,
    surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    bottom: bottom != null ? PreferredSize(child: bottom, preferredSize: Size.fromHeight(50)) : null,
  );
}
