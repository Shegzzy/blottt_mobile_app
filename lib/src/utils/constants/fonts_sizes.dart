import 'package:flutter/material.dart';

import 'dimensions.dart';

class Fonts {
  static TextStyle fontRobot({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    double? height,
    double? letterSpacing,
    TextOverflow? textOverflow,
  }) =>
      TextStyle(
        fontFamily: 'Robot',
        fontSize: fontSize ?? Dimensions.font18,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color ?? Colors.white,
        decoration: decoration ?? TextDecoration.none,
        fontStyle: fontStyle ?? FontStyle.normal,
        height: height ?? 0.0,
        letterSpacing: letterSpacing ?? 0.0,
        overflow: textOverflow
      );
}