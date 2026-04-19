import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class AppIconBadge extends StatelessWidget {
  const AppIconBadge({
    super.key,
    required this.icon,
    this.backgroundColor = AppColors.primaryLight,
    this.iconColor = AppColors.primary,
    this.size = 44,
    this.iconSize = 22,
    this.borderRadius,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? AppRadius.smAll,
      ),
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}