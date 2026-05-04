import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_shadows.dart';
import '../../router/route_paths.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/display/progress_ring.dart';
import '../../widgets/navigation/lumina_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const _AppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: AppSizes.md),
                _WelcomeSection(),
                const SizedBox(height: AppSizes.sm),
                _DashboardGrid(),
                const SizedBox(height: AppSizes.md),
                _ActionGrid(),
                const SizedBox(height: AppSizes.md),
                _RecentMasteryCard(),
                const SizedBox(height: 120), // Bottom spacing to clear nav bar
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();
  @override
  Widget build(BuildContext context) {
    return const SliverLuminaAppBar(
      title: 'FlutterMaster',
      showLogo: true,
      showProfile: true,
      showSearch: true,
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Alex!',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your learning progress is accelerating. Ready for today\'s goal?',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: AppColors.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _StreakBadge(),
      ],
    );
  }
}

class _StreakBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: AppColors.outlineVariant, width: 1),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 20),
          const SizedBox(width: 6),
          const Text(
            '12 Day Streak',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _DailyGoalCard()),
              const SizedBox(width: AppSizes.md),
              Expanded(child: _TodaysChallengeCard()),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DailyGoalCard(),
            const SizedBox(height: AppSizes.md),
            _TodaysChallengeCard(),
          ],
        );
      },
    );
  }
}

class _DailyGoalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'DAILY GOAL',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          ProgressRing(
            progress: 0.75,
            size: 140,
            strokeWidth: 10,
            label: '75%',
            sublabel: 'Complete',
          ),
          const SizedBox(height: AppSizes.lg),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            ),
            child: Text(
              '3/4 Lessons Finished',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodaysChallengeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Stack(
        children: [
          // Badge
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
              child: Text(
                'EXPERT',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TODAY'S CHALLENGE",
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Isolates & Multithreading',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Master background processing in Flutter to keep your UI jank-free even during heavy computation.',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(RoutePaths.challenge),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Start Challenge',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.play_arrow_rounded, size: 24),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return Row(
            children: [
              Expanded(
                child: _ActionTile(
                  title: 'New Concept',
                  subtitle: 'Learn today',
                  icon: Icons.add_rounded,
                  iconBg: AppColors.primary.withValues(alpha: 0.1),
                  iconColor: AppColors.primary,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionTile(
                  title: 'Search',
                  subtitle: 'Find solutions',
                  icon: Icons.search_rounded,
                  iconBg: AppColors.secondary.withValues(alpha: 0.1),
                  iconColor: AppColors.secondary,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionTile(
                  title: 'Quick Quiz',
                  subtitle: 'Test yourself',
                  icon: Icons.bolt_rounded,
                  iconBg: AppColors.tertiary.withValues(alpha: 0.1),
                  iconColor: AppColors.tertiary,
                  onTap: () {},
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            _ActionTile(
              title: 'New Concept',
              subtitle: 'Learn something new today',
              icon: Icons.add_rounded,
              iconBg: const Color(0xFFEEF2FF),
              iconColor: const Color(0xFF4F46E5),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _ActionTile(
              title: 'Search Problems',
              subtitle: 'Find specific solutions',
              icon: Icons.search_rounded,
              iconBg: const Color(0xFFECFEFF),
              iconColor: const Color(0xFF0891B2),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _ActionTile(
              title: 'Quick Quiz',
              subtitle: 'Test your knowledge',
              icon: Icons.bolt_rounded,
              iconBg: const Color(0xFFFFF7ED),
              iconColor: const Color(0xFFEA580C),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      borderRadius: 24,
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.outlineVariant, size: 20),
        ],
      ),
    );
  }
}

class _RecentMasteryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RECENT MASTERY',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        const _MasteryTile(title: 'State Management', progress: 0.85, color: AppColors.primary),
        const SizedBox(height: 12),
        const _MasteryTile(title: 'Custom Painting', progress: 0.40, color: AppColors.secondary),
      ],
    );
  }
}

class _MasteryTile extends StatelessWidget {
  final String title;
  final double progress;
  final Color color;

  const _MasteryTile({required this.title, required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.auto_stories_rounded, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: color.withValues(alpha: 0.1),
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${(progress * 100).toInt()}%',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
