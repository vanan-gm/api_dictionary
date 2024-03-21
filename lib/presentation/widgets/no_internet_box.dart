import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:flutter/material.dart';

class NoInternetBox extends StatelessWidget {
  const NoInternetBox({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        Container(
          width: widthScreen - AppConstants.paddingDefault * 2,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusContainer),
            color: AppColors.onyx.withOpacity(.5),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingDefault,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingDefault,
            vertical: AppConstants.paddingDefault,
          ),
        ),
        Positioned(
          left: 3,
          child: Container(
            height: 65,
            width: (widthScreen - AppConstants.paddingDefault * 2) - 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.radiusContainer),
                color: AppColors.white,
                boxShadow: [BoxShadow(
                  color: AppColors.onyx.withOpacity(.8),
                  spreadRadius: .1,
                  blurRadius: .1,
                  offset: const Offset(.2, .2),
                )]
            ),
            margin: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingDefault,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingDefault,
              vertical: AppConstants.paddingDefault,
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.onyx.withOpacity(.5),
                  ),
                  padding: EdgeInsets.all(AppConstants.paddingDefault),
                  child: const AssetIcon(icon: AssetPaths.icNoInternet, size: AppConstants.iconSmallSize, color: AppColors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: AppConstants.paddingDefault,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('You\'re offline now', style: AppStyles.appStyle(color: AppColors.black, fontSize: AppConstants.fontAppBarSize),),
                      Text('Opps! Internet is disconnected', style: AppStyles.appStyle(color: AppColors.onyx.withOpacity(.75), fontSize: AppConstants.fontSmallSize),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
