import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/navigation/lumina_app_bar.dart';

class MasteryDashboardScreen extends StatelessWidget {
  const MasteryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverLuminaAppBar(
                title: 'Profile',
                showLogo: true,
                showProfile: false,
                showSearch: false,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? AppSizes.xl : AppSizes.md,
                  vertical: AppSizes.md,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildHeader(isWide),
                    const SizedBox(height: AppSizes.md),
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                _buildStatCards(isWide),
                                const SizedBox(height: AppSizes.sm),
                                _buildRankCard(),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSizes.md),
                          Expanded(
                            flex: 2,
                            child: _buildExpertiseSpectrum(isWide),
                          ),
                        ],
                      )
                    else ...[
                      _buildStatCards(isWide),
                      const SizedBox(height: AppSizes.sm),
                      _buildRankCard(),
                      const SizedBox(height: AppSizes.md),
                      _buildExpertiseSpectrum(isWide),
                    ],
                    const SizedBox(height: AppSizes.md),
                    _buildLearningMomentum(isWide),
                    const SizedBox(height: AppSizes.md),
                    _buildAchievementGallery(isWide),
                    const SizedBox(height: 120),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(bool isWide) {
    return Column(
      children: [
        Text(
          'Mastery Dashboard',
          style: TextStyle(
            color: AppColors.onSurface,
            fontSize: isWide ? 48 : 32,
            fontWeight: FontWeight.w800,
            fontFamily: 'Inter',
            letterSpacing: -1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.xs),
        Text(
          'Track your evolution from enthusiast to architect.',
          style: TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: isWide ? 18 : 14,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatCards(bool isWide) {
    return Column(
      children: [
        const _StatCard(
          icon: Icons.auto_awesome_mosaic_rounded,
          title: 'CONCEPTS MASTERED',
          value: '142',
          total: '180',
          progress: 142 / 180,
          color: AppColors.primary,
        ),
        const SizedBox(height: AppSizes.sm),
        const _StatCard(
          icon: Icons.quiz_rounded,
          title: 'QUIZZES PASSED',
          value: '48',
          total: '50',
          progress: 48 / 50,
          color: AppColors.secondary,
        ),
      ],
    );
  }

  Widget _buildRankCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF4F46E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT RANK',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Senior Artisan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.md),
              const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 32),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            'Top 5% of learners this month',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertiseSpectrum(bool isWide) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWide)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildExpertiseText(),
                ),
                const SizedBox(width: AppSizes.md),
                _buildRadarBadge(),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildExpertiseText(),
                const SizedBox(height: AppSizes.sm),
                _buildRadarBadge(),
              ],
            ),
          const SizedBox(height: AppSizes.lg),
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: CustomPaint(
                painter: RadarChartPainter(),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Center(
            child: Column(
              children: [
                Text(
                  'Primary Strength',
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'UI Architecture',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                const SizedBox(
                  width: 300,
                  child: Text(
                    'You\'re excelling at complex layouts and animations. Testing coverage is your next frontier for total mastery.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningMomentum(bool isWide) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWide)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildMomentumText(),
                ),
                const SizedBox(width: AppSizes.md),
                _buildMomentumLegend(),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMomentumText(),
                const SizedBox(height: AppSizes.sm),
                _buildMomentumLegend(),
              ],
            ),
          const SizedBox(height: AppSizes.lg),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeatmapGrid(),
                const SizedBox(height: AppSizes.md),
                const SizedBox(
                  width: 432, // Matches heatmap width: 24 cols * 18px
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SEPTEMBER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      Text('OCTOBER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      Text('NOVEMBER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      Text('DECEMBER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertiseText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Expertise Spectrum',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Balanced across core Flutter pillars.',
          style: TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildRadarBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      ),
      child: const Text(
        'LIVE RADAR',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMomentumText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Learning Momentum',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Visualizing your coding streaks over the last 12 weeks.',
          style: TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildMomentumLegend() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Less', style: TextStyle(fontSize: 10)),
        const SizedBox(width: 4),
        ...List.generate(4, (index) {
          return Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1 + (index * 0.2)),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
        const SizedBox(width: 4),
        const Text('More', style: TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _buildAchievementGallery(bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Achievement Gallery',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.md),
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _AchievementCard(
                icon: Icons.military_tech_rounded,
                title: 'State Management Guru',
                status: 'LVL 5',
                isUnlocked: true,
                badgeColor: Color(0xFF8B4513),
              ),
              SizedBox(width: AppSizes.md),
              _AchievementCard(
                icon: Icons.bolt_rounded,
                title: '7-Day Coding Streak',
                status: 'HOT',
                isUnlocked: true,
                badgeColor: AppColors.primary,
              ),
              SizedBox(width: AppSizes.md),
              _AchievementCard(
                icon: Icons.terminal_rounded,
                title: 'Clean Code Architect',
                status: 'NEW UNLOCKED',
                isUnlocked: true,
                isNew: true,
                badgeColor: Colors.teal,
              ),
              SizedBox(width: AppSizes.md),
              _AchievementCard(
                icon: Icons.lock_outline_rounded,
                title: 'Animation Master',
                status: 'LOCKED',
                isUnlocked: false,
              ),
              SizedBox(width: AppSizes.md),
              _AchievementCard(
                icon: Icons.lock_outline_rounded,
                title: 'CI/CD Expert',
                status: 'LOCKED',
                isUnlocked: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String total;
  final double progress;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.total,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          value,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' / $total',
                          style: TextStyle(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String status;
  final bool isUnlocked;
  final bool isNew;
  final Color? badgeColor;

  const _AchievementCard({
    required this.icon,
    required this.title,
    required this.status,
    required this.isUnlocked,
    this.isNew = false,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: 180,
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: (badgeColor ?? Colors.grey).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isUnlocked ? (badgeColor ?? AppColors.primary) : Colors.grey.withValues(alpha: 0.4),
                  size: 40,
                ),
              ),
              if (isNew)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isUnlocked ? (badgeColor ?? AppColors.primary) : Colors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isUnlocked ? AppColors.onSurface : AppColors.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeatmapGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(7, (row) {
        return Row(
          children: List.generate(24, (col) {
            final opacity = (row + col) % 5 == 0 ? 0.8 : (row + col) % 3 == 0 ? 0.4 : 0.1;
            return Container(
              width: 14,
              height: 14,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: opacity),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      }),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final List<String> labels = ['UI/UX', 'API', 'DEVOPS', 'TESTING', 'PERF', 'STATE'];
  final List<double> values = [0.9, 0.6, 0.5, 0.4, 0.7, 0.8];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.7;
    final sides = labels.length;
    final angle = (2 * math.pi) / sides;

    final bgPaint = Paint()
      ..color = AppColors.outlineVariant.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw background concentric polygons
    for (var i = 1; i <= 5; i++) {
      final r = radius * (i / 5);
      final path = Path();
      for (var j = 0; j < sides; j++) {
        final curAngle = angle * j - math.pi / 2;
        final point = Offset(
          center.dx + r * math.cos(curAngle),
          center.dy + r * math.sin(curAngle),
        );
        if (j == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      path.close();
      canvas.drawPath(path, bgPaint);
    }

    // Draw axis lines and labels
    final labelStyle = TextStyle(
      color: AppColors.onSurfaceVariant,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );

    for (var j = 0; j < sides; j++) {
      final curAngle = angle * j - math.pi / 2;
      final point = Offset(
        center.dx + radius * math.cos(curAngle),
        center.dy + radius * math.sin(curAngle),
      );
      canvas.drawLine(center, point, bgPaint);

      // Label positioning
      final labelPoint = Offset(
        center.dx + (radius + 20) * math.cos(curAngle),
        center.dy + (radius + 20) * math.sin(curAngle),
      );
      final textPainter = TextPainter(
        text: TextSpan(text: labels[j], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        labelPoint - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }

    // Draw data polygon
    final dataPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    
    final strokePaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final dataPath = Path();
    for (var j = 0; j < sides; j++) {
      final curAngle = angle * j - math.pi / 2;
      final r = radius * values[j];
      final point = Offset(
        center.dx + r * math.cos(curAngle),
        center.dy + r * math.sin(curAngle),
      );
      if (j == 0) {
        dataPath.moveTo(point.dx, point.dy);
      } else {
        dataPath.lineTo(point.dx, point.dy);
      }
    }
    dataPath.close();
    canvas.drawPath(dataPath, dataPaint);
    canvas.drawPath(dataPath, strokePaint);
    
    // Draw data points
    final dotPaint = Paint()..color = AppColors.primary;
    for (var j = 0; j < sides; j++) {
      final curAngle = angle * j - math.pi / 2;
      final r = radius * values[j];
      final point = Offset(
        center.dx + r * math.cos(curAngle),
        center.dy + r * math.sin(curAngle),
      );
      canvas.drawCircle(point, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
