import 'package:flutter/material.dart';

class AssetIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color? color;
  const AssetIcon({super.key, required this.icon, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(icon, width: size, height: size, color: color);
  }
}
