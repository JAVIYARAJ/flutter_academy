import 'package:flutter/material.dart';

import '../../../core/config/app_environment.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

class HomePlaceholderScreen extends StatelessWidget {
  const HomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.architecture_rounded, size: 56),
              const SizedBox(height: AppSizes.md),
              const Text(
                AppStrings.appTagline,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.sm),
              const Text(
                AppStrings.initialRouteLabel,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                AppEnvironment.hasSupabaseConfig
                    ? 'Supabase config detected.'
                    : AppStrings.supabasePendingLabel,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
