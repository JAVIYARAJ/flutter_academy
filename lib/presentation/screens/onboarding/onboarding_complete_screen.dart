import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_shadows.dart';
import '../../router/route_paths.dart';

class OnboardingCompleteScreen extends StatelessWidget {
  const OnboardingCompleteScreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildCircularHero(),
            const SizedBox(height: 32),
            Text(
              "You're all set, Alex!",
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your learning path is ready. We\'ve\ncustomized your experience based on your goals.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 40),
            _buildGoalCard(),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSmallStatCard('Level', 'Intermediate', Icons.bar_chart_rounded, Colors.indigo),
                const SizedBox(width: 16),
                _buildSmallStatCard('Commitment', '30 min/day', Icons.access_time_rounded, Colors.blue),
              ],
            ),
            const SizedBox(height: 16),
            _buildSpecializationTag(),
            const SizedBox(height: 32),
            _buildProTip(),
            const SizedBox(height: 48),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularHero() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 240,
          height: 240,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: AppShadows.soft,
          ),
          child: ClipOval(
            child: Image.network(
              'https://images.unsplash.com/photo-1551288049-bbbda5366391?q=80&w=2070&auto=format&fit=crop', // Data visualization/Future tech
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.check_circle_outline_rounded, size: 80, color: AppColors.primary),
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              shape: BoxShape.circle,
              boxShadow: AppShadows.premium,
            ),
            child: const Icon(Icons.check_rounded, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.rocket_launch_outlined, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Primary Goal',
                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Build Production Apps',
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.onSurface),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecializationTag() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.code_rounded, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            'UI/UX Specialization Track',
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary),
          ),
          const Spacer(),
          const Icon(Icons.verified_rounded, color: Color(0xFF10B981), size: 18),
        ],
      ),
    );
  }

  Widget _buildProTip() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.lightbulb_outline_rounded, color: AppColors.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pro Tip',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
              ),
              Text(
                'Download our offline code playground to practice your Flutter snippets even without an internet connection.',
                style: GoogleFonts.inter(fontSize: 13, color: AppColors.onSurfaceVariant, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.go(RoutePaths.home),
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
                const Text('Go to Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: Text(
            'Update Preferences',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
