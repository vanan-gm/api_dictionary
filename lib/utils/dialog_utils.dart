import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/extensions/string_ext.dart';
import 'package:api_dictionary/injector.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:api_dictionary/presentation/widgets/ripple_effect.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DialogUtils{

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

  Future<void> showVoiceDialog(BuildContext context, Function(String) onConfirm) async{
    ValueNotifier<String> text = ValueNotifier('');
    ValueNotifier<double> confidentValue = ValueNotifier(0.0);
    final result = await showDialog(context: context, builder: (context){
      handleStartListening(confidentValue, text);
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusRound)),
        icon: Row(
          children: [
            const Spacer(),
            RippleEffect(
              onPressed: () => Navigator.of(context).pop(),
              radius: AppConstants.radiusCircle,
              child: const AssetIcon(icon: AssetPaths.icClose, size: AppConstants.iconSmallSize),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: text,
              builder: (context, word, _){
                return Column(
                  children: [
                    Text(word.isEmpty ? 'We\'re listening...' : 'Are you looking for this word',
                      style: AppStyles.appStyle(), textAlign: TextAlign.center),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppConstants.paddingSmall,
                      ),
                      child: Text(word.isNotEmpty ? word.upperCaseFirstLetter() : word, style: AppStyles.appStyle(
                        fontSize: AppConstants.fontGiantSize, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                    ),
                    if(word.isNotEmpty) Padding(
                      padding: EdgeInsets.only(top: AppConstants.paddingDefault),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RippleEffect(
                            onPressed: (){
                              text.value = '';
                              handleStartListening(confidentValue, text);
                            },
                            child: const AssetIcon(icon: AssetPaths.icReset, size: AppConstants.iconBigSize, color: AppColors.crimson,),
                          ),
                          RippleEffect(
                            onPressed: () => Navigator.of(context).pop(text.value),
                            child: const AssetIcon(icon: AssetPaths.icForward, size: AppConstants.iconBigSize, color: AppColors.green,),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      );
    });
    getIt<SpeechToText>().stop();
    if(result != null && result is String) onConfirm(result);
  }

  Future<void> handleStartListening(ValueNotifier<double> confidentValue, ValueNotifier<String> text) async{
    await getIt<SpeechToText>().initialize();
    await getIt<SpeechToText>().listen(onResult: (result){
      for(var rs in result.alternates){
        if(rs.recognizedWords.trim().isEmpty) return;
        if(rs.confidence <= 1.0 && rs.confidence > confidentValue.value){
          confidentValue.value = rs.confidence;
          text.value = rs.recognizedWords;
          getIt<SpeechToText>().stop();
        }
      }
    }, localeId: 'en_US');
  }
}