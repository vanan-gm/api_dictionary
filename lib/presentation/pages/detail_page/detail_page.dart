import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/extensions/string_ext.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:api_dictionary/presentation/pages/base_page/base_page.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:flutter/material.dart';

class DetailPage extends BasePage {
  final Word word;
  const DetailPage({super.key, required this.word});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends BasePageState<DetailPage> with RootPage{

  @override
  Widget appBarWidget() => Text('Definition', style: AppStyles.appStyle(color: AppColors.white, fontSize: AppConstants.fontAppBarSize));

  @override
  Color statusBarColor() => AppColors.crimson;

  @override
  Color appBarColor() => AppColors.crimson;

  @override
  bool useLeading() => true;

  @override
  double? toolbarHeight() => 220;

  @override
  PreferredSize? bottom() => PreferredSize(
    preferredSize: const Size.fromHeight(0.0),
    child: Container(
      color: AppColors.crimson,
      padding: EdgeInsets.symmetric(
        vertical: AppConstants.paddingDefault,
      ),
      child: Column(
        children: [
          Text(widget.word.word.upperCaseFirstLetter(), textAlign: TextAlign.center,
            style: AppStyles.appStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: AppConstants.fontGiantSize),),
          Text(widget.word.phonetic, style: AppStyles.appStyle(color: AppColors.white.withOpacity(.7), fontStyle: FontStyle.italic),),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingDefault,
            ).copyWith(top: AppConstants.paddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                functionBox(icon: AssetPaths.icVoice, title: 'Voice'),
                functionBox(icon: AssetPaths.icEmptyStar, title: 'Save'),
                functionBox(icon: AssetPaths.icShare, title: 'Share'),
                functionBox(icon: AssetPaths.icCopy, title: 'Copy'),
              ],
            ),
          )
        ],
      ),
    ),
  );

  @override
  Widget buildUi() {
    return Container();
  }

  Widget functionBox({required String icon, required String title}){
    return Container(
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.radiusContainer),
        color: AppColors.grey.withOpacity(.4),
      ),
      padding: EdgeInsets.symmetric(
        vertical: AppConstants.paddingSmall,
      ),
      child: Column(
        children: [
          AssetIcon(icon: icon, size: AppConstants.iconDefaultSize, color: AppColors.white),
          Padding(
            padding: EdgeInsets.only(
              top: AppConstants.paddingSmall,
            ),
            child: Text(title, style: AppStyles.appStyle(color: AppColors.white),)
          )
        ],
      ),
    );
  }

}
