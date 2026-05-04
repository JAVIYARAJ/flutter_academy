import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Typography constants — Inter / Space Grotesk, matching DESIGN.md.
class AppTextStyles {
  const AppTextStyles._();

  static const String _inter = 'Inter';
  static const String _spaceGrotesk = 'SpaceGrotesk';

  static const h1 = TextStyle(
    fontFamily: _inter,
    fontSize: 40,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.02 * 40,
    color: AppColors.onSurface,
  );

  static const h2 = TextStyle(
    fontFamily: _inter,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.01 * 32,
    color: AppColors.onSurface,
  );

  static const h3 = TextStyle(
    fontFamily: _inter,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.onSurface,
  );

  static const bodyLg = TextStyle(
    fontFamily: _inter,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurface,
  );

  static const bodyMd = TextStyle(
    fontFamily: _inter,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.onSurface,
  );

  static const labelCaps = TextStyle(
    fontFamily: _inter,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.05 * 10,
    color: AppColors.onSurfaceVariant,
  );

  static const codeBlock = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: Color(0xFF67E8F9), // cyan-300 equivalent
  );
}
