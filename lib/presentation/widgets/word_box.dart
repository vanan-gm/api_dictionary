import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:api_dictionary/presentation/pages/detail_page/detail_page.dart';
import 'package:api_dictionary/presentation/widgets/circle_dot.dart';
import 'package:api_dictionary/presentation/widgets/ripple_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordBox extends StatelessWidget {
  final Word word;
  final Meanings meanings;
  final VoidCallback? onTap;
  final int? maxLine;
  const WordBox({super.key, required this.word, required this.meanings, this.onTap, this.maxLine});

  @override
  Widget build(BuildContext context) {
    return RippleEffect(
      onPressed: onTap ?? () => Navigator.of(context).push(CupertinoPageRoute(builder: (_) => DetailPage(word: word, chosenType: meanings.partOfSpeech.toLowerCase(),))),
      radius: AppConstants.radiusContainer,
      child: ListTile(
        leading: const CircleDot(),
        title: Text('${word.word} (${meanings.partOfSpeech})', style: AppStyles.appStyle()),
        subtitle: Text(meanings.definitions.first.definition, maxLines: maxLine ?? 3, overflow: TextOverflow.ellipsis,
          style: AppStyles.appStyle(color: AppColors.onyx, fontSize: AppConstants.fontSmallSize),),
        trailing: const Icon(Icons.keyboard_arrow_right, color: AppColors.onyx),
      ),
    );
  }
}
