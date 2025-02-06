import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color? customColor1;
  final Color? customColor2;

  const CustomColors({this.customColor1, this.customColor2});

  @override
  CustomColors copyWith({Color? customColor1, Color? customColor2}) {
    return CustomColors(
      customColor1: customColor1 ?? this.customColor1,
      customColor2: customColor2 ?? this.customColor2,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      customColor1: Color.lerp(customColor1, other.customColor1, t),
      customColor2: Color.lerp(customColor2, other.customColor2, t),
    );
  }
}
