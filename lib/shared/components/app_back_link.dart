import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class AppBackLink extends StatelessWidget {
  const AppBackLink({
    super.key,
    this.label = 'Back',
    this.onTap,
  });

  final String label;

  /// If null, calls [Navigator.pop] automatically.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
    isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back, size: 16, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.bodyMD.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}