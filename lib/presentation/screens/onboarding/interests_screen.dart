import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_shadows.dart';
import '../../router/route_paths.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final Set<int> _selectedIndices = {1, 3}; // Default selections from image

  final List<Map<String, dynamic>> _interests = [
    {
      'title': 'UI & Design',
      'subtitle': 'Layouts, Widgets, Material 3',
      'image': 'https://cdn-icons-png.flaticon.com/512/3659/3659898.png',
      'color': const Color(0xFFE0E7FF),
    },
    {
      'title': 'State Management',
      'subtitle': 'Riverpod, Bloc, Provider',
      'image': 'https://cdn-icons-png.flaticon.com/512/2103/2103633.png',
      'color': const Color(0xFF4338CA),
    },
    {
      'title': 'Backend & Data',
      'subtitle': 'Firebase, Supabase, APIs',
      'image': 'https://cdn-icons-png.flaticon.com/512/2721/2721295.png',
      'color': const Color(0xFFE0F2FE),
    },
    {
      'title': 'Testing',
      'subtitle': 'Unit, Widget, Golden Tests',
      'image': 'https://cdn-icons-png.flaticon.com/512/2040/2040504.png',
      'color': const Color(0xFFFEF3C7),
    },
    {
      'title': 'Architecture',
      'subtitle': 'Clean Architecture, DDD',
      'image': 'https://cdn-icons-png.flaticon.com/512/1055/1055644.png',
      'color': const Color(0xFFF1F5F9),
    },
    {
      'title': 'Native Bridge',
      'subtitle': 'Method Channels, FFI',
      'image': 'https://cdn-icons-png.flaticon.com/512/2164/2164832.png',
      'color': const Color(0xFFF1F5F9),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Flutter Academy',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.go(RoutePaths.home),
            child: Text(
              'Skip',
              style: GoogleFonts.inter(color: AppColors.outline),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What sparks your\ncuriosity?',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Select at least 3 topics to tailor your learning journey.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildInterestsGrid(),
                  const SizedBox(height: 32),
                  _buildProTip(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          _buildFooterActions(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Personalizing experience',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '2 of 4',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.outline,
                ),
              ),
            ],
          ),
        ),
        LinearProgressIndicator(
          value: 0.5,
          backgroundColor: AppColors.outlineVariant.withValues(alpha: 0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 4,
        ),
      ],
    );
  }

  Widget _buildInterestsGrid() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 280,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: isMobile ? 0.9 : 1.1, // Responsive aspect ratio
      ),
      itemCount: _interests.length,
      itemBuilder: (context, index) {
        final interest = _interests[index];
        final isSelected = _selectedIndices.contains(index);
        
        final IconData iconData = _getIconForTopic(interest['title']);
        final Color iconColor = isSelected ? Colors.white : _getIconColorForTopic(interest['title']);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedIndices.remove(index);
              } else {
                _selectedIndices.add(index);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16), // Slightly reduced padding
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.outlineVariant.withValues(alpha: 0.2),
                width: 1.5,
              ),
              boxShadow: isSelected ? AppShadows.premium : AppShadows.soft,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute content
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44, // Slightly smaller icon container
                      height: 44,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white.withValues(alpha: 0.2) : interest['color'],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        iconData,
                        color: iconColor,
                        size: 22,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        interest['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 15, // Slightly smaller font for mobile
                          fontWeight: FontWeight.w800,
                          color: isSelected ? Colors.white : AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        interest['subtitle'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: isSelected ? Colors.white.withValues(alpha: 0.8) : AppColors.onSurfaceVariant,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForTopic(String title) {
    switch (title) {
      case 'UI & Design': return Icons.auto_awesome_mosaic_rounded;
      case 'State Management': return Icons.account_tree_rounded;
      case 'Backend & Data': return Icons.cloud_queue_rounded;
      case 'Testing': return Icons.bug_report_rounded;
      case 'Architecture': return Icons.architecture_rounded;
      case 'Native Bridge': return Icons.terminal_rounded;
      default: return Icons.topic_rounded;
    }
  }

  Color _getIconColorForTopic(String title) {
    switch (title) {
      case 'UI & Design': return const Color(0xFF4338CA);
      case 'State Management': return const Color(0xFF6366F1);
      case 'Backend & Data': return const Color(0xFF0284C7);
      case 'Testing': return const Color(0xFFD97706);
      case 'Architecture': return const Color(0xFF475569);
      case 'Native Bridge': return const Color(0xFF0F172A);
      default: return AppColors.primary;
    }
  }

  Widget _buildProTip() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.premium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'PRO TIP',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF57DFFE),
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Master Widget Composition',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Understanding how Flutter builds its tree is the foundation of every high-performance app.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.1))),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.push(RoutePaths.assessmentIntro),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Continue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'You can update your interests anytime in settings.',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
