import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF96cdee);
  static const accent =  Color(0xFF26A69A);
  static const error = Color(0xFFF50057);
  static const text = Color(0xFF424242);
  static const gray = Color(0xFF696969);
  static const lightGray = Color(0xFFd3d3d3);
  static const negroni = Color(0xFFfee0be);
  static const white = Color(0xFFFFFFFF);

  static final black = Colors.black;
  static final transparent = Colors.transparent;
}

final theme = ThemeData(
  fontFamily: 'Montserrat',
  primaryColor: AppColors.primary,
  accentColor: AppColors.accent,
  highlightColor: Platform.isIOS ? AppColors.transparent : null,
  splashColor: Platform.isIOS ? AppColors.transparent : null,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: AppColors.black),
    elevation: 0,
    brightness: Brightness.light,
  ),
);
