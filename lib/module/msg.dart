import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_sphere/common/controllers.dart';

Future<bool?> globalMsg({required String message}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Controllers.theme.currentThemeData.colorScheme.primary,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
