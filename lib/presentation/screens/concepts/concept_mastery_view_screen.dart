import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/navigation/lumina_app_bar.dart';

class ConceptMasteryViewScreen extends StatelessWidget {
  const ConceptMasteryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isWide = width > 1024;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverLuminaAppBar(
                title: 'InheritedWidget Mastery',
                showLogo: false,
                showSearch: false,
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.margin,
                  vertical: AppSizes.md,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const _Breadcrumbs(),
                    const SizedBox(height: AppSizes.md),
                    const _TitleSection(),
                    const SizedBox(height: AppSizes.lg),
                    if (isWide)
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  const _ExpressiveContentCard(),
                                  const SizedBox(height: AppSizes.md),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Image.asset(
                                        'assets/images/neural_tree.png',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: AppColors.primary.withValues(alpha: 0.05),
                                            child: const Center(
                                              child: Icon(Icons.image_outlined, color: AppColors.primary, size: 48),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.md),
                                  const _CodePlayground(),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSizes.lg),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  const _KeyTakeaways(),
                                  const SizedBox(height: AppSizes.md),
                                  const _KnowledgePath(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        children: [
                          const _ExpressiveContentCard(),
                          const SizedBox(height: AppSizes.md),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                'assets/images/neural_tree.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.primary.withValues(alpha: 0.05),
                                    child: const Center(
                                      child: Icon(Icons.image_outlined, color: AppColors.primary, size: 48),
                                    ),
                                  );
                                },
                               ),
                            ),
                          ),
                          const SizedBox(height: AppSizes.md),
                          const _CodePlayground(),
                          const SizedBox(height: AppSizes.md),
                          const _KeyTakeaways(),
                          const SizedBox(height: AppSizes.md),
                          const _KnowledgePath(),
                        ],
                      ),
                    const SizedBox(height: 120), // Clear nav bar and FAB
                  ]),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: isWide ? 32 : 100, // Account for bottom nav bar on mobile
            left: 0,
            right: 0,
            child: Center(child: const _MasteryFab()),
          ),
        ],
      ),
    );
  }
}

class _Breadcrumbs extends StatelessWidget {
  const _Breadcrumbs();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _crumb('Library'),
        _separator(),
        _crumb('Framework Architecture'),
        _separator(),
        _crumb('InheritedWidget', isLast: true),
      ],
    );
  }

  Widget _crumb(String text, {bool isLast = false}) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: isLast ? FontWeight.w700 : FontWeight.w500,
        color: isLast ? AppColors.primary : AppColors.onSurfaceVariant,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _separator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Icon(Icons.chevron_right_rounded, size: 14, color: AppColors.outlineVariant),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TagsSection(),
        const SizedBox(height: 16),
        Text(
          'Riverpod Providers',
          style: GoogleFonts.inter(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.w800,
            color: AppColors.onSurface,
            letterSpacing: -1.0,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Master the fundamental building blocks of the Riverpod ecosystem. Providers are the entry point to shared state, allowing for reactive and testable Flutter applications.',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _TagsSection extends StatelessWidget {
  const _TagsSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        _tag('State Management', AppColors.primary),
        _tag('Intermediate', AppColors.tertiary),
      ],
    );
  }

  Widget _tag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _ExpressiveContentCard extends StatelessWidget {
  const _ExpressiveContentCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: AppColors.primary),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Concept Overview',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Providers are the most important part of a Riverpod application. A provider is an object that encapsulates a piece of state and allows listening to that state.',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: AppColors.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _RichTextHighlight(
                      text: 'Unlike Provider from the original package, Riverpod providers are global. They are declared as final variables and can be accessed from anywhere in the widget tree using a WidgetRef.',
                      highlights: ['Provider', 'global', 'WidgetRef'],
                    ),
                    const SizedBox(height: 24),
                    _BulletItem(
                      title: 'Provider',
                      desc: 'The most basic provider. It is used for caching a value.',
                    ),
                    _BulletItem(
                      title: 'StateProvider',
                      desc: 'Ideal for simple variables that can be changed by the UI.',
                    ),
                    _BulletItem(
                      title: 'FutureProvider',
                      desc: 'Perfect for handling asynchronous API calls.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RichTextHighlight extends StatelessWidget {
  final String text;
  final List<String> highlights;

  const _RichTextHighlight({required this.text, required this.highlights});

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> spans = [];
    String remaining = text;

    while (remaining.isNotEmpty) {
      int firstIndex = -1;
      String currentHighlight = "";

      for (var h in highlights) {
        int index = remaining.indexOf(h);
        if (index != -1 && (firstIndex == -1 || index < firstIndex)) {
          firstIndex = index;
          currentHighlight = h;
        }
      }

      if (firstIndex == -1) {
        spans.add(TextSpan(text: remaining));
        break;
      }

      if (firstIndex > 0) {
        spans.add(TextSpan(text: remaining.substring(0, firstIndex)));
      }

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              currentHighlight,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      );

      remaining = remaining.substring(firstIndex + currentHighlight.length);
    }

    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          fontSize: 15,
          color: AppColors.onSurfaceVariant,
          height: 1.6,
        ),
        children: spans,
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String title;
  final String desc;

  const _BulletItem({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8, right: 8),
            child: Icon(Icons.circle, size: 6, color: AppColors.onSurface),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.onSurfaceVariant,
                  height: 1.4,
                ),
                children: [
                  TextSpan(text: '$title: ', style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.onSurface)),
                  TextSpan(text: desc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodePlayground extends StatelessWidget {
  const _CodePlayground();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white.withValues(alpha: 0.05),
            child: Row(
              children: [
                const Icon(Icons.code_rounded, color: Colors.white70, size: 14),
                const SizedBox(width: 8),
                Text(
                  'example_provider.dart',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.copy_rounded, color: Colors.white70, size: 14),
                const SizedBox(width: 6),
                Text(
                  'Copy',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.6,
                  ),
                  children: [
                    const TextSpan(text: '// 1. Define the provider globally\n', style: TextStyle(color: Colors.white38)),
                    const TextSpan(text: 'final ', style: TextStyle(color: AppColors.inversePrimary)),
                    const TextSpan(text: 'nameProvider', style: TextStyle(color: AppColors.secondaryContainer)),
                    const TextSpan(text: ' = Provider<'),
                    const TextSpan(text: 'String', style: TextStyle(color: AppColors.secondaryContainer)),
                    const TextSpan(text: '>((ref) {\n'),
                    const TextSpan(text: '  return ', style: TextStyle(color: AppColors.inversePrimary)),
                    const TextSpan(text: "'Riverpod Master'", style: TextStyle(color: Colors.amber)),
                    const TextSpan(text: ';\n});\n\n'),
                    const TextSpan(text: 'class ', style: TextStyle(color: AppColors.inversePrimary)),
                    const TextSpan(text: 'HomeView', style: TextStyle(color: AppColors.secondaryContainer)),
                    const TextSpan(text: ' extends '),
                    const TextSpan(text: 'ConsumerWidget', style: TextStyle(color: AppColors.secondaryContainer)),
                    const TextSpan(text: ' {\n  @override\n  Widget build(BuildContext context, WidgetRef ref) {\n'),
                    const TextSpan(text: '    // 2. Read the provider\n', style: TextStyle(color: Colors.white38)),
                    const TextSpan(text: '    final ', style: TextStyle(color: AppColors.inversePrimary)),
                    const TextSpan(text: 'name', style: TextStyle(color: AppColors.secondaryContainer)),
                    const TextSpan(text: ' = ref.watch(nameProvider);\n'),
                    const TextSpan(text: '    return Text(name);\n  }\n}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyTakeaways extends StatelessWidget {
  const _KeyTakeaways();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline_rounded, color: AppColors.tertiary, size: 24),
              const SizedBox(width: 12),
              Text(
                'Key Takeaways',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _item('Providers are globally declared final variables.'),
          _item('Always use ref.watch() inside build methods for reactivity.'),
          _item('Use ref.read() only for event callbacks like onPressed.'),
        ],
      ),
    );
  }

  Widget _item(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline_rounded, color: AppColors.primary, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KnowledgePath extends StatelessWidget {
  const _KnowledgePath();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.extension_rounded, color: AppColors.secondary, size: 24),
              const SizedBox(width: 12),
              Text(
                'Related Problems',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _problemTile('Dependency Injection with Riverpod'),
          const SizedBox(height: 12),
          _problemTile('AsyncData handling patterns'),
        ],
      ),
    );
  }

  Widget _problemTile(String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.outlineVariant, size: 20),
        ],
      ),
    );
  }
}



class _MasteryFab extends StatelessWidget {
  const _MasteryFab();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: AppColors.primary,
      elevation: 4,
      hoverElevation: 8,
      highlightElevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      ),
      icon: const Icon(Icons.verified_rounded, color: Colors.white, size: 24),
      label: Text(
        'Mark as Mastered',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
