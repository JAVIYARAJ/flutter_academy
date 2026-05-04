import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_shadows.dart';
import '../../router/route_names.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/navigation/lumina_app_bar.dart';

class ExploreConceptsScreen extends StatelessWidget {
  const ExploreConceptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverLuminaAppBar(
            title: 'Explore',
            showLogo: true,
            showProfile: true,
            showSearch: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.margin,
              vertical: AppSizes.md,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _HeroHeader(),
                const SizedBox(height: AppSizes.lg),
                const _SearchField(),
                const SizedBox(height: AppSizes.md),
                const _LevelFilters(),
                const SizedBox(height: AppSizes.sm),
                const _TopicFilters(),
                const SizedBox(height: AppSizes.lg),
                const _ConceptList(),
                const SizedBox(height: AppSizes.lg),
                const _PromoCard(),
                const SizedBox(height: 120),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    return Column(
      children: [
        Text(
          'Concept Directory',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 40 : 64,
            fontWeight: FontWeight.w900,
            color: AppColors.onSurface,
            height: 1.1,
            letterSpacing: -2.0,
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Master the architecture, performance, and UI patterns of production-grade Flutter applications through our technical curriculum.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: TextField(
        style: GoogleFonts.inter(color: AppColors.onSurface, fontSize: 15),
        decoration: InputDecoration(
          hintText: 'Search concepts, widgets, or architecture...',
          hintStyle: GoogleFonts.inter(color: AppColors.outline, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: AppColors.primary, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
    );
  }
}

class _LevelFilters extends StatelessWidget {
  const _LevelFilters();

  @override
  Widget build(BuildContext context) {
    final levels = ['All Levels', 'Beginner', 'Intermediate', 'Expert'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: levels.map((level) {
          final isSelected = level == 'Beginner';
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.outlineVariant,
                ),
              ),
              child: Text(
                level,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TopicFilters extends StatelessWidget {
  const _TopicFilters();

  @override
  Widget build(BuildContext context) {
    final topics = [
      {'label': 'UI & Design', 'icon': Icons.brush_rounded, 'color': const Color(0xFF4F46E5)},
      {'label': 'State Management', 'icon': Icons.layers_rounded, 'color': const Color(0xFF0891B2)},
      {'label': 'Performance', 'icon': Icons.speed_rounded, 'color': const Color(0xFFEA580C)},
      {'label': 'Networking', 'icon': Icons.hub_rounded, 'color': const Color(0xFF9333EA)},
      {'label': 'Testing', 'icon': Icons.bug_report_rounded, 'color': const Color(0xFFE11D48)},
      {'label': 'Security', 'icon': Icons.security_rounded, 'color': const Color(0xFF059669)},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: topics.map((topic) {
        final color = topic['color'] as Color;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
            boxShadow: AppShadows.soft,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(topic['icon'] as IconData, size: 14, color: color),
              const SizedBox(width: 8),
              Text(
                topic['label'] as String,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ConceptList extends StatelessWidget {
  const _ConceptList();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
        
        if (crossAxisCount > 1) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 420,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _getConcept(context, index);
            },
          );
        }

        return Column(
          children: [
            _getConcept(context, 0),
            const SizedBox(height: 24),
            _getConcept(context, 1),
            const SizedBox(height: 24),
            _getConcept(context, 2),
          ],
        );
      },
    );
  }

  Widget _getConcept(BuildContext context, int index) {
    final concepts = [
      _ConceptCard(
        title: 'InheritedWidget Architecture',
        description: 'Deep dive into the underlying mechanism of context-based data...',
        icon: Icons.hub_outlined,
        iconBg: AppColors.secondary.withValues(alpha: 0.1),
        iconColor: AppColors.secondary,
        status: 'REVISION',
        level: 'EXPERT',
        time: '15 MIN',
        isFavorite: true,
        progress: 0.75,
        onTap: () => context.pushNamed(RouteNames.conceptDetail),
      ),
      _ConceptCard(
        title: 'RepaintBoundary Optimization',
        description: 'Isolate heavy animations from the rest of the widget tree to boost FPS.',
        icon: Icons.auto_graph_rounded,
        iconBg: AppColors.primary.withValues(alpha: 0.1),
        iconColor: AppColors.primary,
        status: '',
        level: 'INTERMEDIATE',
        time: '8 MIN',
        isFavorite: false,
        progress: 0.30,
        onTap: () => context.pushNamed(RouteNames.conceptDetail),
      ),
      _ConceptCard(
        title: 'SliverLayout Mastery',
        description: 'Create complex, custom scrolling experiences using the sliver protocol.',
        icon: Icons.layers_outlined,
        iconBg: AppColors.tertiary.withValues(alpha: 0.1),
        iconColor: AppColors.tertiary,
        status: '',
        level: 'BEGINNER',
        time: '20 MIN',
        isFavorite: true,
        progress: 1.0,
        isCompleted: true,
        onTap: () => context.pushNamed(RouteNames.conceptDetail),
      ),
    ];
    return concepts[index];
  }
}

class _ConceptCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String status;
  final String level;
  final String time;
  final bool isFavorite;
  final double progress;
  final bool isCompleted;
  final VoidCallback? onTap;

  const _ConceptCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.status,
    required this.level,
    required this.time,
    required this.isFavorite,
    required this.progress,
    this.isCompleted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      borderRadius: AppSizes.radiusMd,
      overflowHidden: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: iconColor, size: 24),
                    ),
                    if (status.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  children: [
                    _InfoChip(icon: Icons.show_chart_rounded, label: level),
                    _InfoChip(icon: Icons.access_time_rounded, label: time),
                    if (isFavorite) ...[
                      _InfoChip(icon: Icons.star_outline_rounded, label: 'FAVORITE', color: const Color(0xFFF59E0B), bg: const Color(0xFFFFFBEB)),
                    ],
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'MASTERY LEVEL',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      isCompleted ? 'COMPLETED' : '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isCompleted ? const Color(0xFF10B981) : AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    Container(
                      height: 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: isCompleted ? const Color(0xFF10B981) : AppColors.secondary,
                          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final Color? bg;

  const _InfoChip({required this.icon, required this.label, this.color, this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bg ?? AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color ?? AppColors.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color ?? AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryContainer],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NEW LEARNING PATH',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Mastering\nRenderObjects',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.0,
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Go beneath the widget tree to the pixel-pushing engine. Learn how Flutter actually paints.',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              elevation: 0,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enroll Now',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
