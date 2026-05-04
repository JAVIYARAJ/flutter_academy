import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_shadows.dart';
import '../../router/route_paths.dart';

class AssessmentIntroScreen extends StatelessWidget {
  const AssessmentIntroScreen({super.key});

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
                children: [
                  _buildHeroImage(),
                  const SizedBox(height: 40),
                  Text(
                    'Find your perfect\nstarting point',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Take a quick 5-minute diagnostic to\ntailor your Flutter learning journey.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildFeatureList(),
                ],
              ),
            ),
          ),
          _buildFooterActions(context),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: 0.75,
          backgroundColor: AppColors.outlineVariant.withValues(alpha: 0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 4,
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppShadows.soft,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Image.network(
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=2064&auto=format&fit=crop', // Abstract shapes
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.auto_awesome_mosaic_rounded, size: 48, color: AppColors.outlineVariant)),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    return Column(
      children: [
        _buildFeatureItem(
          icon: Icons.bolt_rounded,
          title: 'Personalized Path',
          subtitle: 'Skip what you already know and focus on new concepts.',
          color: const Color(0xFFF0FDF4),
          iconColor: Colors.green,
        ),
        const SizedBox(height: 16),
        _buildFeatureItem(
          icon: Icons.analytics_outlined,
          title: 'Skill Insights',
          subtitle: 'Get a detailed breakdown of your technical proficiency.',
          color: const Color(0xFFEEF2FF),
          iconColor: AppColors.primary,
        ),
        const SizedBox(height: 16),
        _buildFeatureItem(
          icon: Icons.track_changes_rounded,
          title: 'Targeted Projects',
          subtitle: 'Unlock practical challenges suited for your level.',
          color: const Color(0xFFECFEFF),
          iconColor: const Color(0xFF00687A),
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterActions(BuildContext context) {
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
              onPressed: () => context.push(RoutePaths.onboardingComplete),
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
                  const Text('Start Assessment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Approx. duration: 5 minutes • 12 questions',
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
