import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppColors {
  // https://rydmike.com/flexcolorscheme/themesplayground-latest/
  static const flexScheme = FlexScheme.bahamaBlue;

  static Color greyShade500(bool isLight) =>
      isLight ? Colors.grey.shade500 : Colors.grey.shade600;
}
