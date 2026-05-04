import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_shadows.dart';
import '../../router/route_paths.dart';
import '../../widgets/navigation/lumina_app_bar.dart';
import '../../widgets/cards/glass_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All Quizzes', 'Fundamentals', 'Advanced UI', 'Architecture'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          final horizontalPadding = isWide ? AppSizes.xl * 2 : AppSizes.margin;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverLuminaAppBar(
                title: 'Quizzes',
                showLogo: true,
                showProfile: false,
                showSearch: false,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: AppSizes.lg,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildHero(isWide),
                    const SizedBox(height: AppSizes.md),
                    _buildCategoryFilters(),
                    const SizedBox(height: AppSizes.md),
                    _buildSearchBar(),
                    const SizedBox(height: AppSizes.md),
                    _buildQuizGrid(isWide),
                    const SizedBox(height: AppSizes.md),
                    _buildSuggestTopic(isWide),
                    const SizedBox(height: AppSizes.md),
                    _buildAssessmentBanner(isWide),
                    const SizedBox(height: 120), // Spacer for bottom nav
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHero(bool isWide) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF8FAFC),
            const Color(0xFFEFF6FF),
            const Color(0xFFE0E7FF).withValues(alpha: 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (isWide) ...[
            // Decorative circles for Web
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF4F46E5).withValues(alpha: 0.08),
                      const Color(0xFF4F46E5).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 100,
              bottom: -80,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF0891B2).withValues(alpha: 0.05),
                      const Color(0xFF0891B2).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.all(isWide ? 64 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                  child: Text(
                    'FEATURED MODULE',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF4F46E5),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Master the Ecosystem',
                  style: GoogleFonts.inter(
                    fontSize: isWide ? 48 : 28,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1E293B),
                    letterSpacing: -1.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: isWide ? 600 : double.infinity,
                  child: Text(
                    'Deepen your Dart and Flutter expertise through curated assessments designed by industry veterans. Track your progression from novice to master.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      height: 1.6,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withValues(alpha: 0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => context.push(RoutePaths.activeQuiz),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F46E5),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text('Start Daily Quiz', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF0891B2),
                        side: const BorderSide(color: Color(0xFF0891B2), width: 1.5),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                        backgroundColor: Colors.white.withValues(alpha: 0.7),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('View Learning Path', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
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

  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = _selectedCategoryIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_categories[index]),
              selected: isSelected,
              onSelected: (val) => setState(() => _selectedCategoryIndex = index),
              backgroundColor: Colors.white,
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                side: BorderSide(
                  color: isSelected ? Colors.transparent : AppColors.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search quizzes...',
          hintStyle: TextStyle(color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
          prefixIcon: const Icon(Icons.search, color: AppColors.onSurfaceVariant),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildQuizGrid(bool isWide) {
    final List<_QuizData> quizzes = [
      _QuizData(
        title: 'Widget Lifecycle',
        description: 'Deep dive into initState, didChangeDependencies, and disposal phases.',
        duration: '12 min',
        difficulty: 'Intermediate',
        status: 'MASTERED',
        progress: 1.0,
        icon: Icons.waves_rounded,
        color: const Color(0xFFEEF2FF),
        iconColor: AppColors.primary,
      ),
      _QuizData(
        title: 'Navigation 2.0',
        description: 'Mastering Router, RouterDelegate, and declarative navigation patterns.',
        duration: '25 min',
        difficulty: 'Advanced',
        status: 'IN PROGRESS',
        progress: 0.45,
        icon: Icons.alt_route_rounded,
        color: const Color(0xFFF0FDFA),
        iconColor: Colors.teal,
      ),
      _QuizData(
        title: 'Performance Optimization',
        description: 'Repaint boundaries, const constructors, and DevTools profiling techniques.',
        duration: '18 min',
        difficulty: 'Advanced',
        status: 'NOT STARTED',
        progress: 0.0,
        icon: Icons.speed_rounded,
        color: const Color(0xFFFFF7ED),
        iconColor: Colors.orange,
      ),
      _QuizData(
        title: 'Riverpod & State',
        description: 'Understanding Providers, Notifiers, and the Riverpod architecture flow.',
        duration: '20 min',
        difficulty: 'Intermediate',
        status: 'IN PROGRESS',
        progress: 0.85,
        icon: Icons.hub_rounded,
        color: const Color(0xFFF5F3FF),
        iconColor: Colors.deepPurple,
      ),
      _QuizData(
        title: 'Dart 3 Features',
        description: 'Records, pattern matching, and sealed classes in the modern Dart era.',
        duration: '15 min',
        difficulty: 'Beginner',
        status: 'IN PROGRESS',
        progress: 0.12,
        icon: Icons.code_rounded,
        color: const Color(0xFFF0F9FF),
        iconColor: Colors.blue,
      ),
    ];

    if (isWide) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: AppSizes.md,
          mainAxisSpacing: AppSizes.md,
          mainAxisExtent: 380,
        ),
        itemCount: quizzes.length,
        itemBuilder: (context, index) => _QuizCard(data: quizzes[index]),
      );
    }

    return Column(
      children: quizzes.map((q) => Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.md),
        child: _QuizCard(data: q),
      )).toList(),
    );
  }

  Widget _buildSuggestTopic(bool isWide) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? AppSizes.xl : AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.1),
          width: 1.5,
          style: BorderStyle.solid,
        ),
      ),
      child: isWide 
        ? Row(
            children: [
              _buildSuggestIcon(),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSuggestTitle(),
                    const SizedBox(height: 4),
                    _buildSuggestDescription(),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              _buildSuggestButton(),
            ],
          )
        : Column(
            children: [
              _buildSuggestIcon(),
              const SizedBox(height: 16),
              _buildSuggestTitle(),
              const SizedBox(height: 8),
              _buildSuggestDescription(),
              const SizedBox(height: 24),
              _buildSuggestButton(),
            ],
          ),
    );
  }

  Widget _buildSuggestIcon() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.lightbulb_outline_rounded, color: AppColors.primary, size: 28),
    );
  }

  Widget _buildSuggestTitle() {
    return Text(
      'Missing a topic?',
      style: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.onSurface,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildSuggestDescription() {
    return Text(
      'Suggest a new quiz topic and help us expand the FlutterMaster ecosystem.',
      style: GoogleFonts.inter(
        color: AppColors.onSurfaceVariant,
        fontSize: 14,
        height: 1.5,
      ),
    );
  }

  Widget _buildSuggestButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.1)),
        ),
      ),
      child: const Text('Submit Request', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildAssessmentBanner(bool isWide) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(isWide ? AppSizes.xl : AppSizes.lg),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                        ),
                        child: const Text(
                          'PERSONALIZED PATH',
                          style: TextStyle(color: Color(0xFFA5B4FC), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Not sure where to start?',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: isWide ? 28 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Take our 5-minute Skill Assessment to identify your current level and get a custom-tailored learning roadmap.',
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1E293B),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text('Find My Path', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                if (isWide) const Spacer(flex: 1),
                if (isWide)
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1517976487492-5750f3195933?auto=format&fit=crop&q=80&w=800'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (!isWide)
            Positioned(
              right: -50,
              bottom: -50,
              child: Opacity(
                opacity: 0.1,
                child: Image.network(
                  'https://images.unsplash.com/photo-1517976487492-5750f3195933?auto=format&fit=crop&q=80&w=800',
                  width: 250,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuizData {
  final String title;
  final String description;
  final String duration;
  final String difficulty;
  final String status;
  final double progress;
  final IconData icon;
  final Color color;
  final Color iconColor;

  _QuizData({
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.status,
    required this.progress,
    required this.icon,
    required this.color,
    required this.iconColor,
  });
}

class _QuizCard extends StatelessWidget {
  final _QuizData data;

  const _QuizCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final statusColor = data.status == 'MASTERED' 
        ? AppColors.emerald 
        : data.status == 'IN PROGRESS' 
            ? Colors.orange 
            : AppColors.onSurfaceVariant.withValues(alpha: 0.4);

    return GlassCard(
      padding: const EdgeInsets.all(AppSizes.md),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: data.color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(data.icon, color: data.iconColor, size: 24),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  data.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            data.title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 14, color: AppColors.onSurfaceVariant.withValues(alpha: 0.6)),
              const SizedBox(width: 4),
              Text(data.duration, style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant.withValues(alpha: 0.8))),
              const SizedBox(width: 16),
              Icon(Icons.bar_chart_rounded, size: 14, color: AppColors.onSurfaceVariant.withValues(alpha: 0.6)),
              const SizedBox(width: 4),
              Text(data.difficulty, style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant.withValues(alpha: 0.8))),
            ],
          ),
              if (constraints.hasBoundedHeight) const Spacer() else const SizedBox(height: AppSizes.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mastery Progress', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
                  Text('${(data.progress * 100).toInt()}%', style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                child: LinearProgressIndicator(
                  value: data.progress,
                  minHeight: 6,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    data.status == 'MASTERED' ? AppColors.emerald : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.push(RoutePaths.activeQuiz),
              style: ElevatedButton.styleFrom(
                backgroundColor: data.status == 'NOT STARTED' ? AppColors.surfaceContainerHigh : AppColors.primary,
                foregroundColor: data.status == 'NOT STARTED' ? AppColors.onSurface : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                data.status == 'MASTERED' 
                    ? 'Retake Quiz' 
                    : data.status == 'IN PROGRESS' 
                        ? 'Continue Quiz' 
                        : 'Enroll Now',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
                ],
              );
            },
          ),
        );
      }
    }

