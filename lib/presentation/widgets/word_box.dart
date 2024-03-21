import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:api_dictionary/presentation/pages/detail_page/detail_page.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:api_dictionary/presentation/widgets/ripple_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordBox extends StatelessWidget {
  final Word word;
  final Meanings meanings;
  final VoidCallback? onTap;
  const WordBox({super.key, required this.word, required this.meanings, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RippleEffect(
      onPressed: onTap ?? () => Navigator.of(context).push(CupertinoPageRoute(builder: (_) => DetailPage(word: word))),
      radius: AppConstants.radiusContainer,
      child: ListTile(
        leading: const AssetIcon(icon: AssetPaths.icSphere, size: AppConstants.iconTinySize, color: AppColors.crimson),
        title: Text('${word.word} (${meanings.partOfSpeech})', style: AppStyles.appStyle()),
        subtitle: Text(meanings.definitions.first.definition,
          style: AppStyles.appStyle(color: AppColors.onyx, fontSize: AppConstants.fontSmallSize),),
        trailing: const Icon(Icons.keyboard_arrow_right, color: AppColors.onyx),
      ),
    );
  }
}
