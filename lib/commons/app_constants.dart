import 'package:flutter/material.dart';

class AppConstants{
  AppConstants._();

  static MediaQueryData get mediaQuery => MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single);
  static double get widthScreen => mediaQuery.size.width;
  static double get heightScreen => mediaQuery.size.height;

  // FontSizes
  static const double fontSmallSize = 12;
  static const double fontMediumSize = 13;
  static const double fontDefaultSize = 14;
  static const double fontAppBarSize = 15;
  static const double fontBigSize = 16;
  static const double fontLargeSize = 17;
  static const double fontHugeSize = 18;
  static const double fontGiantSize = 24;

  // Elevations
  static const double elevationZero = 0.0;

  // Icons
  static const double iconTinySize = 16;
  static const double iconSmallSize = 18;
  static const double iconMediumSize = 20;
  static const double iconDefaultSize = 24;
  static const double iconBigSize = 26;
  static const double iconLargeSize = 28;
  static const double iconHugeSize = 30;

  // Paddings
  static const double paddingZero = 0.0;
  static double paddingTiny = AppConstants.widthScreen * .005;
  static double paddingSmallest = AppConstants.widthScreen * .01;
  static double paddingSmall = AppConstants.widthScreen * .02;
  static double paddingDefault = AppConstants.widthScreen * .03;
  static double paddingBig = AppConstants.widthScreen * .04;
  static double paddingLarge = AppConstants.widthScreen * .05;
  static double paddingHuge = AppConstants.widthScreen * .08;
  static double paddingGiant = AppConstants.widthScreen * .1;

  // Radius
  static const double radiusImage = 5.0;
  static const double radiusContainer = 8.0;
  static const double radiusDialog = 15.0;
  static const double radiusRound = 20.0;
  static const double radiusCircle = 50.0;

  // Icon BoxConstraint
  static const double suffixWith = 50;

  // Radius
  static const Duration responseTimeout = Duration(seconds: 30);
}