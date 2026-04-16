import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ────────────────────────────────────
  static const primary = Color(0xFF6B4EFF);
  static const primaryLight = Color(0xFFF0ECFF);
  static const primaryDark = Color(0xFF4F35D6);

  // ── Semantic ─────────────────────────────────
  static const success = Color(0xFF22C55E);
  static const successBg = Color(0xFFDCFCE7);
  static const error = Color(0xFFEF4444);
  static const errorBg = Color(0xFFFEE2E2);
  static const warning = Color(0xFFF59E0B);
  static const warningBg = Color(0xFFFEF3C7);

  // ── Neutrals — Light ─────────────────────────
  static const background = Color(0xFFF5F5F5);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF9F9F9);
  static const border = Color(0xFFE5E5E5);
  static const borderFocused = primary;
  static const divider = Color(0xFFF0F0F0);

  // ── Text — Light ─────────────────────────────
  static const textPrimary = Color(0xFF111111);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);
  static const textDisabled = Color(0xFFD1D5DB);
  static const textInverse = Color(0xFFFFFFFF);
  static const textLink = primary;

  // ── Neutrals — Dark ──────────────────────────
  static const backgroundDark = Color(0xFF0F0F0F);
  static const surfaceDark = Color(0xFF1A1A1A);
  static const surfaceVariantDark = Color(0xFF242424);
  static const borderDark = Color(0xFF2E2E2E);
  static const dividerDark = Color(0xFF1F1F1F);

  // ── Text — Dark ───────────────────────────────
  static const textPrimaryDark = Color(0xFFF9F9F9);
  static const textSecondaryDark = Color(0xFF9CA3AF);
  static const textTertiaryDark = Color(0xFF6B7280);
  static const textDisabledDark = Color(0xFF4B5563);
}
