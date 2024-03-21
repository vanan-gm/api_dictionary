import 'dart:math';

import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:flutter/material.dart';

class DummyWordBox extends StatelessWidget {
  const DummyWordBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(.45),
          shape: BoxShape.circle,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 15,
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(.45),
                borderRadius: BorderRadius.circular(AppConstants.radiusContainer),
              ),
            ),
          ),
          const Spacer(flex: 4),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(2,
          (index) => Container(
            width: AppConstants.widthScreen * .7,
            height: 15,
            margin: EdgeInsets.only(top: AppConstants.paddingSmallest),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(.45),
              borderRadius: BorderRadius.circular(AppConstants.radiusContainer),
            ),
          ),
        ),
      ),
      trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.grey.withOpacity(.45)),
    );
  }
}
