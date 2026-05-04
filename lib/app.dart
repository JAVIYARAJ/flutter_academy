import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'presentation/bloc/app/app_bloc.dart';
import 'presentation/router/app_router.dart';

class FlutterLearningApp extends StatelessWidget {
  const FlutterLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc()..add(const AppStarted()),
      child: MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
