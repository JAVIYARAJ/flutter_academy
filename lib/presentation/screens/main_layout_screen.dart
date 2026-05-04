import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class MainLayoutScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayoutScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;

        return Scaffold(
          body: Row(
            children: [
              if (isWide)
                _buildNavigationRail(context),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? AppSizes.lg : 0,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: navigationShell,
                    ),
                  ),
                ),
              ),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: isWide ? null : _buildBottomBar(),
        );
      },
    );
  }

  Widget _buildNavigationRail(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          right: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          // Branding
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 48),
          // Main Destinations
          Expanded(
            child: Column(
              children: [
                _RailItem(
                  icon: Icons.home_rounded,
                  label: 'HOME',
                  isSelected: navigationShell.currentIndex == 0,
                  onTap: () => _goBranch(0),
                ),
                _RailItem(
                  icon: Icons.school_rounded,
                  label: 'Learn',
                  isSelected: navigationShell.currentIndex == 1,
                  onTap: () => _goBranch(1),
                ),
                _RailItem(
                  icon: Icons.quiz_rounded,
                  label: 'Quiz',
                  isSelected: navigationShell.currentIndex == 2,
                  onTap: () => _goBranch(2),
                ),
                _RailItem(
                  icon: Icons.terminal_rounded,
                  label: 'Path',
                  isSelected: navigationShell.currentIndex == 3,
                  onTap: () => _goBranch(3),
                ),
                _RailItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  isSelected: navigationShell.currentIndex == 4,
                  onTap: () => _goBranch(4),
                ),
              ],
            ),
          ),
          // Bottom Actions
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings_outlined, color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.help_outline_rounded, color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest.withValues(alpha: 0.95),
            border: Border(
              top: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_rounded,
                    label: 'HOME',
                    isSelected: navigationShell.currentIndex == 0,
                    onTap: () => _goBranch(0),
                  ),
                  _NavItem(
                    icon: Icons.school_outlined,
                    label: 'Learn',
                    isSelected: navigationShell.currentIndex == 1,
                    onTap: () => _goBranch(1),
                  ),
                  _NavItem(
                    icon: Icons.quiz_outlined,
                    label: 'Quiz',
                    isSelected: navigationShell.currentIndex == 2,
                    onTap: () => _goBranch(2),
                  ),
                  _NavItem(
                    icon: Icons.terminal_outlined,
                    label: 'Path',
                    isSelected: navigationShell.currentIndex == 3,
                    onTap: () => _goBranch(3),
                  ),
                  _NavItem(
                    icon: Icons.person_outline_rounded,
                    label: 'Profile',
                    isSelected: navigationShell.currentIndex == 4,
                    onTap: () => _goBranch(4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _RailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RailItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.onSurfaceVariant.withValues(alpha: 0.6);

    return InkWell(
      onTap: onTap,
      hoverColor: AppColors.primary.withValues(alpha: 0.05),
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Positioned(
                right: 0,
                top: 15,
                bottom: 15,
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.0),
                        AppColors.primary.withValues(alpha: 0.08),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    icon,
                    color: color,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                    letterSpacing: 1.2,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? AppColors.primary
        : AppColors.onSurfaceVariant.withValues(alpha: 0.6);

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
