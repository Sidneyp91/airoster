import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

export 'app_colors.dart';
export 'app_spacing.dart';
export 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _buildTheme(brightness: Brightness.light);
  static ThemeData get darkTheme => _buildTheme(brightness: Brightness.dark);

  static ThemeData _buildTheme({required Brightness brightness}) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = isDark ? _darkColorScheme : _lightColorScheme;
    final textColor =
    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final subtitleColor =
    isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      fontFamily: 'Inter',
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // ── Scaffold ──────────────────────────────
      scaffoldBackgroundColor:
      isDark ? AppColors.backgroundDark : AppColors.background,

      // ── AppBar ────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        foregroundColor: textColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTextStyles.headingSM.copyWith(color: textColor),
        iconTheme: IconThemeData(color: textColor, size: 20),
      ),

      // ── Card ──────────────────────────────────
      cardTheme: CardThemeData(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        elevation: 0,
        // shape: RounddRectangleBorder(
        //   borderRadius: AppRadius.mdAll,
        //   side: BorderSide(
        //     color: isDark ? AppColors.borderDark : AppColors.border,
        //   ),
        // ),
        margin: EdgeInsets.zero,
      ),

      // ── ElevatedButton (primary filled) ───────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textInverse,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.4),
          disabledForegroundColor: AppColors.textInverse.withOpacity(0.6),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          textStyle: AppTextStyles.labelLG.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      // ── OutlinedButton (secondary) ────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          textStyle: AppTextStyles.labelLG.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      // ── TextButton (ghost / skip) ─────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          textStyle: AppTextStyles.labelLG,
        ),
      ),

      // ── TextField ─────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor:
        isDark ? AppColors.surfaceVariantDark : AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: AppTextStyles.bodyMD.copyWith(color: subtitleColor),
        labelStyle: AppTextStyles.bodyMD.copyWith(color: subtitleColor),
      ),

      // ── Divider ───────────────────────────────
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.dividerDark : AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ── ListTile ──────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        titleTextStyle: AppTextStyles.bodyMD.copyWith(color: textColor),
        subtitleTextStyle: AppTextStyles.bodySM.copyWith(color: subtitleColor),
      ),

      // ── Text Theme ────────────────────────────
      textTheme: TextTheme(
        displayLarge:
        AppTextStyles.displayLarge.copyWith(color: textColor),
        displayMedium:
        AppTextStyles.displaySmall.copyWith(color: textColor),
        headlineLarge:
        AppTextStyles.headingXL.copyWith(color: textColor),
        headlineMedium:
        AppTextStyles.headingLG.copyWith(color: textColor),
        headlineSmall:
        AppTextStyles.headingMD.copyWith(color: textColor),
        titleLarge: AppTextStyles.headingSM.copyWith(color: textColor),
        titleMedium: AppTextStyles.labelLG.copyWith(color: textColor),
        titleSmall: AppTextStyles.labelMD.copyWith(color: textColor),
        bodyLarge: AppTextStyles.bodyLG.copyWith(color: textColor),
        bodyMedium: AppTextStyles.bodyMD.copyWith(color: subtitleColor),
        bodySmall: AppTextStyles.bodySM.copyWith(color: subtitleColor),
        labelLarge: AppTextStyles.labelLG.copyWith(color: textColor),
        labelMedium: AppTextStyles.labelMD.copyWith(color: textColor),
        labelSmall: AppTextStyles.labelSM.copyWith(color: textColor),
      ),
    );
  }

  // ── Color Schemes ─────────────────────────────

  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.textInverse,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.textSecondary,
    onSecondary: AppColors.textInverse,
    secondaryContainer: AppColors.border,
    onSecondaryContainer: AppColors.textPrimary,
    error: AppColors.error,
    onError: AppColors.textInverse,
    errorContainer: AppColors.errorBg,
    onErrorContainer: AppColors.error,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceContainerHighest: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.border,
    outlineVariant: AppColors.divider,
    scrim: Colors.black,
    inverseSurface: AppColors.textPrimary,
    onInverseSurface: AppColors.textInverse,
    inversePrimary: AppColors.primaryLight,
  );

  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.textInverse,
    primaryContainer: Color(0xFF2D1F7A),
    onPrimaryContainer: AppColors.primaryLight,
    secondary: AppColors.textSecondaryDark,
    onSecondary: AppColors.textInverse,
    secondaryContainer: AppColors.surfaceVariantDark,
    onSecondaryContainer: AppColors.textPrimaryDark,
    error: AppColors.error,
    onError: AppColors.textInverse,
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: AppColors.errorBg,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    surfaceContainerHighest: AppColors.surfaceVariantDark,
    onSurfaceVariant: AppColors.textSecondaryDark,
    outline: AppColors.borderDark,
    outlineVariant: AppColors.dividerDark,
    scrim: Colors.black,
    inverseSurface: AppColors.textPrimaryDark,
    onInverseSurface: AppColors.backgroundDark,
    inversePrimary: AppColors.primaryDark,
  );
}
