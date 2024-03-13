import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:flutter/material.dart';

class RippleEffect extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? radius;
  final Widget child;

  const RippleEffect({
    Key? key,
    required this.child,
    this.onPressed,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: AppColors.transparent,
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(radius ?? AppConstants.radiusContainer),
            ),
          ),
        ),
      ],
    );
  }
}