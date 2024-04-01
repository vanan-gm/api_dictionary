import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:flutter/material.dart';

class CircleDot extends StatelessWidget {
  final double? dotSize;
  const CircleDot({super.key, this.dotSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dotSize ?? AppConstants.dotSize,
      height: dotSize ?? AppConstants.dotSize,
      decoration: const BoxDecoration(
        color: AppColors.crimson,
        shape: BoxShape.circle,
      ),
    );
  }
}
