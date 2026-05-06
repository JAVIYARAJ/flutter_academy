import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home/home_screen.dart';
import '../screens/main_layout_screen.dart';
import '../screens/placeholder_screen.dart';
import '../screens/concepts/explore_concepts_screen.dart';
import '../screens/challenge/daily_challenge_screen.dart';
import '../screens/concepts/concept_mastery_view_screen.dart';
import '../screens/progress/mastery_dashboard_screen.dart';
import '../screens/quizzes/quiz_screen.dart';
import '../screens/quizzes/active_quiz_screen.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/onboarding/interests_screen.dart';
import '../screens/onboarding/assessment_intro_screen.dart';
import '../screens/onboarding/onboarding_complete_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import 'route_names.dart';
import 'route_paths.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorLearnKey = GlobalKey<NavigatorState>(debugLabel: 'shellLearn');
final _shellNavigatorPracticeKey = GlobalKey<NavigatorState>(debugLabel: 'shellPractice');
final _shellNavigatorStatsKey = GlobalKey<NavigatorState>(debugLabel: 'shellStats');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.login,
    routes: <RouteBase>[
      GoRoute(
        path: RoutePaths.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.interests,
        builder: (context, state) => const InterestsScreen(),
      ),
      GoRoute(
        path: RoutePaths.assessmentIntro,
        builder: (context, state) => const AssessmentIntroScreen(),
      ),
      GoRoute(
        path: RoutePaths.onboardingComplete,
        builder: (context, state) => const OnboardingCompleteScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayoutScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: RoutePaths.home,
                name: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorLearnKey,
            routes: [
              GoRoute(
                path: '/learn',
                builder: (context, state) => const ExploreConceptsScreen(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    name: RouteNames.conceptDetail,
                    builder: (context, state) => const ConceptMasteryViewScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorPracticeKey,
            routes: [
              GoRoute(
                path: RoutePaths.quiz,
                name: RouteNames.quiz,
                builder: (context, state) => const QuizScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorStatsKey,
            routes: [
              GoRoute(
                path: '/path',
                builder: (context, state) => const PlaceholderScreen(title: 'Path'),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const MasteryDashboardScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.challenge,
        name: RouteNames.challenge,
        builder: (context, state) => const DailyChallengeScreen(),
      ),
      GoRoute(
        path: RoutePaths.activeQuiz,
        name: RouteNames.activeQuiz,
        builder: (context, state) => const ActiveQuizScreen(),
      ),
    ],
  );
}
