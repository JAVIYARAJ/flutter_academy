import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_shadows.dart';
import '../../widgets/navigation/lumina_app_bar.dart';

class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverLuminaAppBar(
            title: 'Daily Quiz',
            showLogo: false,
            showSearch: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.margin,
              vertical: AppSizes.lg,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _ChallengeHero(),
                const SizedBox(height: AppSizes.lg),
                _QuestionCard(
                  selectedIndex: selectedIndex,
                  onSelected: (index) => setState(() => selectedIndex = index),
                ),
                const SizedBox(height: AppSizes.lg),
                const _StreakPill(),
                const SizedBox(height: AppSizes.xl),
                ElevatedButton(
                  onPressed: selectedIndex != null ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                    elevation: 4,
                    shadowColor: AppColors.primary.withValues(alpha: 0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Submit Answer',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.1),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Double check your answer! You can only submit once.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeHero extends StatelessWidget {
  const _ChallengeHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: const Border(
          left: BorderSide(color: Color(0xFF0E7490), width: 4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flash_on_rounded, color: Color(0xFF0E7490), size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'DAILY CHALLENGE',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0E7490),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Flutter Performance Master',
                    style: GoogleFonts.inter(
                      color: AppColors.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Test your knowledge of background processing and heavy computation in the Flutter ecosystem.',
                    style: GoogleFonts.inter(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final int? selectedIndex;
  final Function(int) onSelected;

  const _QuestionCard({required this.selectedIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: AppShadows.premium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Text(
                  'Topic: Multithreading',
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.access_time_rounded, size: 16, color: AppColors.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text(
                    'Ends in 14h',
                    style: GoogleFonts.inter(color: AppColors.onSurfaceVariant, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'What is the primary use case for',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.onSurface),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'compute()',
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'in Flutter?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.onSurface),
          ),
          const SizedBox(height: 24),
          _OptionTile(
            letter: 'A',
            text: 'Managing global application state across widgets',
            isSelected: selectedIndex == 0,
            onTap: () => onSelected(0),
          ),
          const SizedBox(height: 12),
          _OptionTile(
            letter: 'B',
            text: 'Running heavy computations in a separate Isolate',
            isSelected: selectedIndex == 1,
            onTap: () => onSelected(1),
          ),
          const SizedBox(height: 12),
          _OptionTile(
            letter: 'C',
            text: 'Handling local database persistence with SQLite',
            isSelected: selectedIndex == 2,
            onTap: () => onSelected(2),
          ),
          const SizedBox(height: 12),
          _OptionTile(
            letter: 'D',
            text: 'Updating the UI on every frame of an animation',
            isSelected: selectedIndex == 3,
            onTap: () => onSelected(3),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String letter;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.letter,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }
}

class _StreakPill extends StatelessWidget {
  const _StreakPill();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: List.generate(3, (index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Icon(Icons.local_fire_department_rounded, color: AppColors.secondary, size: 20),
              )),
            ),
            const SizedBox(width: 12),
            const Text(
              '3 Day Streak!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
