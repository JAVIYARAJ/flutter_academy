import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_shadows.dart';

bool _shouldHideOnWeb(BuildContext context) {
  if (!kIsWeb) return false;
  final isWide = MediaQuery.of(context).size.width > 800;
  if (!isWide) return false;

  // We only hide the app bar if we are inside the main navigation shell
  // because the sidebar handles branding there.
  final shell = StatefulNavigationShell.maybeOf(context);
  return shell != null;
}

class LuminaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showLogo;
  final bool showProfile;
  final bool showSearch;
  final bool isTransparent;

  const LuminaAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.showLogo = true,
    this.showProfile = false,
    this.showSearch = true,
    this.isTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    if (_shouldHideOnWeb(context)) return const SizedBox.shrink();
    
    return Container(
      decoration: BoxDecoration(
        color: isTransparent 
            ? Colors.transparent 
            : AppColors.surfaceContainerLowest.withValues(alpha: 0.95),
        boxShadow: isTransparent ? null : AppShadows.premium,
        border: isTransparent 
            ? null 
            : Border(
                bottom: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            leading: leading ?? (showLogo 
                ? _LuminaLogo() 
                : IconButton(
                    onPressed: () => context.canPop() ? context.pop() : context.go('/'),
                    icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface, size: 24),
                  )),
            leadingWidth: showLogo ? (MediaQuery.of(context).size.width < 600 ? 60 : 180) : null,
            title: title != null 
                ? Text(
                    title!,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.5,
                    ),
                  )
                : null,
            actions: actions ?? [
              if (showSearch)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, color: AppColors.onSurfaceVariant),
                ),
              if (showProfile)
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.surfaceContainerHigh,
                    child: Icon(
                      Icons.person_outline_rounded, 
                      size: 20, 
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SliverLuminaAppBar extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showLogo;
  final bool showProfile;
  final bool showSearch;
  final bool pinned;
  final bool floating;

  const SliverLuminaAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.showLogo = true,
    this.showProfile = false,
    this.showSearch = true,
    this.pinned = true,
    this.floating = true,
  });

  @override
  Widget build(BuildContext context) {
    if (_shouldHideOnWeb(context)) return const SliverToBoxAdapter(child: SizedBox.shrink());
    
    return SliverAppBar(
      pinned: pinned,
      floating: floating,
      backgroundColor: AppColors.surfaceContainerLowest.withValues(alpha: 0.95),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border(
            bottom: BorderSide(
              color: AppColors.primary.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
      ),
      leading: leading ?? (showLogo 
          ? _LuminaLogo() 
          : IconButton(
              onPressed: () => context.canPop() ? context.pop() : context.go('/'),
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface, size: 24),
            )),
      leadingWidth: showLogo ? (MediaQuery.of(context).size.width < 600 ? 60 : 180) : null,
      title: title != null 
          ? Text(
              title!,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
                letterSpacing: -0.5,
              ),
            )
          : null,
      actions: actions ?? [
        if (showSearch)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.onSurfaceVariant),
          ),
        if (showProfile)
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.surfaceContainerHigh,
              child: Icon(
                Icons.person_outline_rounded, 
                size: 20, 
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}

class _LuminaLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 18),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 8),
            const Text(
              'FlutterMaster',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
