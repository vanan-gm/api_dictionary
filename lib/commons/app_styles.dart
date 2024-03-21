import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:flutter/material.dart';

class AppStyles{
  AppStyles._();

  static TextStyle appStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    FontStyle? fontStyle,
}) => TextStyle(
    fontFamily: AssetPaths.appFont,
    color: color ?? AppColors.black,
    fontSize: fontSize ?? AppConstants.fontDefaultSize,
    fontWeight: fontWeight ?? FontWeight.w500,
    decoration: decoration ?? TextDecoration.none,
    fontStyle: fontStyle,
  );
}