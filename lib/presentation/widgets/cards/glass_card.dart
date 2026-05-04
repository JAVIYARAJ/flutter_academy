import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_shadows.dart';

/// A glassmorphic card — semi-transparent white surface with backdrop blur,
/// thin border, and a subtle hover-scale animation.
class GlassCard extends StatefulWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSizes.lg),
    this.borderRadius = AppSizes.radiusMd,
    this.onTap,
    this.width,
    this.height,
    this.useHoverEffect = true,
    this.overflowHidden = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool useHoverEffect;
  final bool overflowHidden;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onEnter(_) {
    if (!widget.useHoverEffect) return;
    setState(() => _hovered = true);
    _ctrl.forward();
  }

  void _onExit(_) {
    if (!widget.useHoverEffect) return;
    setState(() => _hovered = false);
    _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_ctrl.value * 0.02), // Subtle scale effect
            child: child,
          );
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                  boxShadow: _hovered ? AppShadows.premiumHover : AppShadows.premium,
                ),
                clipBehavior:
                    widget.overflowHidden ? Clip.antiAlias : Clip.none,
                child: Padding(
                  padding: widget.padding,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
