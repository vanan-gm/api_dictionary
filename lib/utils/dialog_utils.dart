import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DialogUtils{
  DialogUtils._();

  static void showNetworkErrorDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusRound)),
        content: Container(
          padding: EdgeInsets.symmetric(
            vertical: AppConstants.paddingDefault,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please connect to Internet before perform your request', style: AppStyles.appStyle(), textAlign: TextAlign.center),
              Lottie.asset(AssetPaths.ltError, fit: BoxFit.cover, width: 150, height: 150),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.crimson,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingGiant),
                  child: Text('Ok', style: AppStyles.appStyle(color: AppColors.white),)
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}