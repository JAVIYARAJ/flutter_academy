import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

import '../widgets/navigation/lumina_app_bar.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: LuminaAppBar(
        title: title,
        showProfile: true,
      ),
      body: Center(
        child: Text(
          '$title Screen\n(Coming Soon)',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
