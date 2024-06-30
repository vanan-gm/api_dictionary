import 'package:responsive_sizer/responsive_sizer.dart';

class AppConstants{
  AppConstants._();

  // Here we will get screen size (100% of width and height)
  static double get widthScreen => Adaptive.w(100);
  static double get heightScreen => Adaptive.h(100);

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

  // Size
  static const double dotSize = 8;

  // Icon BoxConstraint
  static const double suffixWith = 50;

  // Radius
  static const Duration responseTimeout = Duration(seconds: 30);

  // Other Constants
  static const String recentWordsList = 'recentWordsList';
}