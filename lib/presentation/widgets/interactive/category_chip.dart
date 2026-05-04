import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

/// Pill-shaped category chip — semi-transparent with colored border.
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    this.color = AppColors.primary,
    this.backgroundColor,
    this.isSelected = false,
    this.onTap,
  });

  final String label;
  final Color color;
  final Color? backgroundColor;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = isSelected 
        ? color 
        : (backgroundColor ?? color.withValues(alpha: 0.12));
    final textColor = isSelected ? Colors.white : color;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.sm,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          border: Border.all(
            color: isSelected ? Colors.transparent : color.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
