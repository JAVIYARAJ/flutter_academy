# WEEK 1 IMPLEMENTATION GUIDE
## Foundation & Data Layer Setup

**Goal:** By end of Week 1, you have a compiled, type-safe project with a full database schema. No UI yet—just domain, data, and core utilities.

**Time Estimate:** 30-35 hours spread across 5 days
**Daily Breakdown:** 6-7 hours/day

---

## DAY 1: PROJECT SETUP & STRUCTURE

### Step 1.1: Create Flutter Project

```bash
cd ~/projects
flutter create flutter_learning_hub
cd flutter_learning_hub

# Update minimum SDK to 3.2
# Edit pubspec.yaml:
# environment:
#   sdk: ">=3.2.0 <4.0.0"
#   flutter: ">=3.16.0"
```

### Step 1.2: Add Dependencies

Create your `pubspec.yaml` with these exact versions (compatible set):

```yaml
name: flutter_learning_hub
description: Personal Flutter learning and interview prep platform
publish_to: "none"

environment:
  sdk: ">=3.2.0 <4.0.0"
  flutter: ">=3.16.0"

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0

  # Database
  drift: ^2.14.0
  sqlite3_flutter_libs: ^0.5.0

  # Navigation
  go_router: ^13.0.0

  # UI & Markdown
  flutter_markdown: ^0.6.0
  highlight: ^0.7.0
  intl: ^0.19.0

  # JSON & Freezed
  freezed_annotation: ^2.4.0
  json_serializable: ^6.7.0
  uuid: ^4.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.0
  build_runner: ^2.4.0
  drift_dev: ^2.14.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  riverpod_generator: ^2.3.0

flutter:
  uses-material-design: true
```

```bash
flutter pub get
```

### Step 1.3: Create Directory Structure

```bash
mkdir -p lib/{core,domain,data,presentation,utils}
mkdir -p lib/core/{constants,extensions,theme}
mkdir -p lib/domain/{entities,repositories}
mkdir -p lib/data/{local,repositories}
mkdir -p lib/data/local/{database,migrations,mappers}
mkdir -p lib/presentation/{providers,screens,widgets,router}
mkdir -p lib/presentation/widgets/{common,cards,forms,display,interactive}
mkdir -p lib/presentation/screens/{home,concepts,quizzes,problems,interview,review,progress,search,settings}
mkdir -p lib/utils/{helpers,formatters}
mkdir -p test/{domain,data,presentation}
```

### Step 1.4: Create Constants & Utilities

Create `lib/core/constants/app_strings.dart`:

```dart
class AppStrings {
  // App
  static const String appName = 'Flutter Learning Hub';
  
  // Categories
  static const String categoryUI = 'UI';
  static const String categoryStateManagement = 'State Management';
  static const String categoryNavigation = 'Navigation';
  static const String categoryPerformance = 'Performance';
  static const String categoryAsync = 'Async Programming';
  static const String categoryTesting = 'Testing';
  static const String categoryArchitecture = 'Architecture';
  static const String categoryDesignPatterns = 'Design Patterns';
  static const String categoryBestPractices = 'Best Practices';
  static const String categoryAdvanced = 'Advanced';
  static const String categoryPackages = 'Popular Packages';

  // Learning Status
  static const String statusNotStarted = 'Not Started';
  static const String statusLearning = 'Learning';
  static const String statusMastered = 'Mastered';
  static const String statusRevisiting = 'Revisiting';

  // Difficulty
  static const String difficultyBeginner = 'Beginner';
  static const String difficultyIntermediate = 'Intermediate';
  static const String difficultyAdvanced = 'Advanced';
  static const String difficultyExpert = 'Expert';

  // UI Text
  static const String search = 'Search';
  static const String add = 'Add';
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String noData = 'No data found';
  
  // Review
  static const String reviewQueue = 'Review Queue';
  static const String nextReview = 'Next Review';
  static const String rateUnderstanding = 'Rate your understanding';
  static const String hard = 'Hard';
  static const String good = 'Good';
  static const String easy = 'Easy';
}
```

Create `lib/core/extensions/date_extensions.dart`:

```dart
extension DateTimeExtension on DateTime {
  String toFormattedString() {
    return '$day/$month/$year';
  }

  String toTimeAgoString() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  bool isToday() {
    final today = DateTime.now();
    return year == today.year && month == today.month && day == today.day;
  }

  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }
}
```

Create `lib/core/extensions/string_extensions.dart`:

```dart
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  bool isValidEmail() {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(this);
  }

  List<String> toList() {
    return split(',').map((e) => e.trim()).toList();
  }
}
```

Create `lib/core/theme/app_theme.dart`:

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color secondary = Color(0xFF06B6D4); // Cyan
  static const Color success = Color(0xFF10B981); // Emerald
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: secondary,
        error: error,
        surface: neutral50,
      ),
      scaffoldBackgroundColor: neutral50,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: neutral900,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: neutral100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: neutral200),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        error: error,
        surface: neutral900,
      ),
      scaffoldBackgroundColor: neutral900,
      appBarTheme: const AppBarTheme(
        backgroundColor: neutral800,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: neutral800,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
```

---

## DAY 2: DOMAIN LAYER & ENTITIES

### Step 2.1: Create Enums

Create `lib/domain/entities/enums.dart`:

```dart
enum ConceptCategory {
  ui('UI'),
  stateManagement('State Management'),
  navigation('Navigation'),
  performance('Performance'),
  asynchronous('Async Programming'),
  testing('Testing'),
  architecture('Architecture'),
  designPatterns('Design Patterns'),
  bestPractices('Best Practices'),
  advanced('Advanced'),
  packages('Popular Packages');

  final String label;
  const ConceptCategory(this.label);

  static ConceptCategory fromString(String value) {
    return ConceptCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ConceptCategory.ui,
    );
  }
}

enum DifficultyLevel {
  beginner('Beginner'),
  intermediate('Intermediate'),
  advanced('Advanced'),
  expert('Expert');

  final String label;
  const DifficultyLevel(this.label);

  static DifficultyLevel fromString(String value) {
    return DifficultyLevel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => DifficultyLevel.beginner,
    );
  }
}

enum LearningStatus {
  notStarted('Not Started'),
  learning('Learning'),
  mastered('Mastered'),
  revisiting('Revisiting');

  final String label;
  const LearningStatus(this.label);

  static LearningStatus fromString(String value) {
    return LearningStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => LearningStatus.notStarted,
    );
  }
}

enum ReviewRating {
  hard,
  good,
  easy,
}

enum ProblemStatus {
  unsolved('Unsolved'),
  solved('Solved'),
  partiallySolved('Partially Solved');

  final String label;
  const ProblemStatus(this.label);

  static ProblemStatus fromString(String value) {
    return ProblemStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ProblemStatus.unsolved,
    );
  }
}

enum PriorityLevel {
  low('Low'),
  medium('Medium'),
  high('High'),
  critical('Critical');

  final String label;
  const PriorityLevel(this.label);

  static PriorityLevel fromString(String value) {
    return PriorityLevel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PriorityLevel.medium,
    );
  }
}
```

### Step 2.2: Create Entity Classes (Using Freezed)

Create `lib/domain/entities/concept.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'concept.freezed.dart';
part 'concept.g.dart';

@freezed
class Concept with _$Concept {
  const factory Concept({
    required String id,
    required String title,
    required String description,
    required ConceptCategory category,
    required DifficultyLevel difficulty,
    required List<String> tags,
    required String notes,
    required List<String> keyTakeaways,
    required DateTime createdAt,
    required DateTime lastRevisedAt,
    required DateTime nextReviewDate,
    required List<String> codeSnippetsIds,
    required List<String> relatedConceptIds,
    required List<String> problemsIds,
    required LearningStatus learningStatus,
    required double masteryLevel, // 0.0 - 1.0
    required int timesReviewed,
    required double averageRating, // 1.0 - 5.0
    required bool interviewRelevance,
    required String interviewFrequency,
  }) = _Concept;

  factory Concept.fromJson(Map<String, dynamic> json) =>
      _$ConceptFromJson(json);
}
```

Create `lib/domain/entities/code_snippet.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'code_snippet.freezed.dart';
part 'code_snippet.g.dart';

@freezed
class CodeSnippet with _$CodeSnippet {
  const factory CodeSnippet({
    required String id,
    required String conceptId,
    required String title,
    required String code,
    required String explanation,
    required List<String> useCases,
    required List<String> gotchas,
    required List<String> tags,
    required DateTime createdAt,
  }) = _CodeSnippet;

  factory CodeSnippet.fromJson(Map<String, dynamic> json) =>
      _$CodeSnippetFromJson(json);
}
```

Create `lib/domain/entities/problem.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'problem.freezed.dart';
part 'problem.g.dart';

@freezed
class Problem with _$Problem {
  const factory Problem({
    required String id,
    required String title,
    required String description,
    required String context,
    required String solution,
    required List<String> solutionApproaches,
    required List<String> conceptsLinked,
    required String? codeSnippetId,
    required DateTime dateEncountered,
    required DateTime? dateSolved,
    required ProblemStatus status,
    required List<String> tags,
    required PriorityLevel priority,
    required int frequency,
  }) = _Problem;

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);
}
```

Create `lib/domain/entities/quiz.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

@freezed
class Quiz with _$Quiz {
  const factory Quiz({
    required String id,
    required String title,
    required String description,
    required DifficultyLevel difficulty,
    required ConceptCategory category,
    required List<String> questionsIds,
    required int? timeLimit, // in minutes
    required double passingScore, // 0.0 - 1.0
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}

@freezed
class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String id,
    required String quizId,
    required String conceptId,
    required String question,
    required List<QuizOption> options,
    required String correctAnswerId,
    required String explanation,
    required List<String> hints,
    required DifficultyLevel difficulty,
    required int? timeLimit, // in seconds
  }) = _QuizQuestion;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
}

@freezed
class QuizOption with _$QuizOption {
  const factory QuizOption({
    required String id,
    required String text,
    required bool isCorrect,
  }) = _QuizOption;

  factory QuizOption.fromJson(Map<String, dynamic> json) =>
      _$QuizOptionFromJson(json);
}

@freezed
class QuizAttempt with _$QuizAttempt {
  const factory QuizAttempt({
    required String id,
    required String quizId,
    required DateTime startedAt,
    required DateTime? completedAt,
    required double score, // 0.0 - 1.0
    required bool passed,
    required Map<String, String> answers, // questionId -> selectedOptionId
    required int correctAnswersCount,
    required int totalQuestionsCount,
    required int timeTaken, // seconds
    required List<String> conceptsReviewNeeded,
  }) = _QuizAttempt;

  factory QuizAttempt.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptFromJson(json);
}
```

Create `lib/domain/entities/interview.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'interview.freezed.dart';
part 'interview.g.dart';

@freezed
class InterviewQuestion with _$InterviewQuestion {
  const factory InterviewQuestion({
    required String id,
    required String question,
    required String category,
    required DifficultyLevel difficulty,
    required List<String> keyPoints,
    required String sampleAnswer,
    required List<String> commonMistakes,
    required List<String> relatedConcepts,
    required String frequency, // 'Asked often', 'Sometimes', 'Rarely'
  }) = _InterviewQuestion;

  factory InterviewQuestion.fromJson(Map<String, dynamic> json) =>
      _$InterviewQuestionFromJson(json);
}

@freezed
class InterviewAttempt with _$InterviewAttempt {
  const factory InterviewAttempt({
    required String id,
    required String questionId,
    required String userAnswer,
    required DateTime dateAnswered,
    required int rating, // 1-5
    required String notes,
  }) = _InterviewAttempt;

  factory InterviewAttempt.fromJson(Map<String, dynamic> json) =>
      _$InterviewAttemptFromJson(json);
}
```

Create `lib/domain/entities/user.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required DateTime createdAt,
    required int totalConceptsLearned,
    required int totalQuizzesTaken,
    required int currentStreak,
    required int longestStreak,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

Create `lib/domain/entities/daily_progress.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_progress.freezed.dart';
part 'daily_progress.g.dart';

@freezed
class DailyProgress with _$DailyProgress {
  const factory DailyProgress({
    required String id,
    required DateTime date,
    required int conceptsLearned,
    required int conceptsRevisited,
    required int quizzesTaken,
    required double averageQuizScore,
    required int codeSnippetsAdded,
    required int problemsSolved,
    required int totalTimeSpent, // minutes
  }) = _DailyProgress;

  factory DailyProgress.fromJson(Map<String, dynamic> json) =>
      _$DailyProgressFromJson(json);
}
```

### Step 2.3: Generate Freezed Code

```bash
cd ~/projects/flutter_learning_hub
flutter pub run build_runner build --delete-conflicting-outputs
```

If you see errors, check that all freezed dependencies are correct in pubspec.yaml.

### Step 2.4: Create Abstract Repositories

Create `lib/domain/repositories/concept_repository.dart`:

```dart
import '../entities/concept.dart';
import '../entities/enums.dart';

abstract class ConceptRepository {
  Future<List<Concept>> getAllConcepts();
  Future<Concept?> getConceptById(String id);
  Future<List<Concept>> getConceptsDueForReview();
  Future<List<Concept>> getConceptsByCategory(ConceptCategory category);
  Future<List<Concept>> searchConcepts(String query);
  Future<void> createConcept(Concept concept);
  Future<void> updateConcept(Concept concept);
  Future<void> deleteConcept(String id);
  Future<void> updateReviewDate({
    required String conceptId,
    required ReviewRating rating,
  });
}
```

Create `lib/domain/repositories/quiz_repository.dart`:

```dart
import '../entities/quiz.dart';

abstract class QuizRepository {
  Future<List<Quiz>> getAllQuizzes();
  Future<Quiz?> getQuizById(String id);
  Future<void> createQuiz(Quiz quiz);
  Future<void> updateQuiz(Quiz quiz);
  Future<void> deleteQuiz(String id);
  Future<void> saveQuizAttempt(QuizAttempt attempt);
  Future<List<QuizAttempt>> getQuizAttempts(String quizId);
}
```

Create similar files for:
- `lib/domain/repositories/problem_repository.dart`
- `lib/domain/repositories/interview_repository.dart`
- `lib/domain/repositories/progress_repository.dart`

---

## DAY 3: DATABASE LAYER (DRIFT)

### Step 3.1: Create Drift Tables

Create `lib/data/local/database/tables/concepts_table.dart`:

```dart
import 'package:drift/drift.dart';

class ConceptsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get category => text()(); // enum name
  TextColumn get difficulty => text()(); // enum name
  TextColumn get tags => text()(); // JSON array
  
  TextColumn get notes => text()();
  TextColumn get keyTakeaways => text()(); // JSON array
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastRevisedAt => dateTime()();
  DateTimeColumn get nextReviewDate => dateTime()();
  
  TextColumn get codeSnippetsIds => text()(); // JSON array
  TextColumn get relatedConceptIds => text()(); // JSON array
  TextColumn get problemsIds => text()(); // JSON array
  
  TextColumn get learningStatus => text()(); // enum name
  RealColumn get masteryLevel => real()();
  IntColumn get timesReviewed => integer()();
  RealColumn get averageRating => real()();
  
  BoolColumn get interviewRelevance => boolean()();
  TextColumn get interviewFrequency => text()();
  
  @override
  Set<Column> get primaryKey => {id};
  
  @override
  String get tableName => 'concepts';
}
```

Create `lib/data/local/database/tables/code_snippets_table.dart`:

```dart
import 'package:drift/drift.dart';

class CodeSnippetsTable extends Table {
  TextColumn get id => text()();
  TextColumn get conceptId => text()();
  TextColumn get title => text()();
  TextColumn get code => text()();
  TextColumn get explanation => text()();
  TextColumn get useCases => text()(); // JSON array
  TextColumn get gotchas => text()(); // JSON array
  TextColumn get tags => text()(); // JSON array
  
  DateTimeColumn get createdAt => dateTime()();
  
  @override
  Set<Column> get primaryKey => {id};
  @override
  String get tableName => 'code_snippets';
}
```

Create similar table files for:
- `problems_table.dart`
- `quizzes_table.dart`
- `quiz_questions_table.dart`
- `quiz_attempts_table.dart`
- `interview_questions_table.dart`
- `interview_attempts_table.dart`
- `daily_progress_table.dart`
- `users_table.dart`

### Step 3.2: Create Main Database File

Create `lib/data/local/database/app_database.dart`:

```dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/concepts_table.dart';
import 'tables/code_snippets_table.dart';
import 'tables/problems_table.dart';
import 'tables/quizzes_table.dart';
import 'tables/quiz_questions_table.dart';
import 'tables/quiz_attempts_table.dart';
import 'tables/interview_questions_table.dart';
import 'tables/interview_attempts_table.dart';
import 'tables/daily_progress_table.dart';
import 'tables/users_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  ConceptsTable,
  CodeSnippetsTable,
  ProblemsTable,
  QuizzesTable,
  QuizQuestionsTable,
  QuizAttemptsTable,
  InterviewQuestionsTable,
  InterviewAttemptsTable,
  DailyProgressTable,
  UsersTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'flutter_learning_hub');
  }

  // Custom queries
  Future<List<ConceptsTableData>> getConceptsDueForReview() {
    return (select(conceptsTable)
          ..where((c) => c.nextReviewDate.isSmallerThanValue(DateTime.now())))
        .get();
  }

  Future<List<ConceptsTableData>> getConceptsByCategory(String category) {
    return (select(conceptsTable)
          ..where((c) => c.category.equals(category)))
        .get();
  }

  Future<List<ConceptsTableData>> searchConcepts(String query) {
    return (select(conceptsTable)
          ..where((c) =>
              c.title.like('%$query%') | c.description.like('%$query%')))
        .get();
  }
}
```

### Step 3.3: Generate Drift Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## DAY 4: UTILITIES & HELPERS

### Step 4.1: Spaced Repetition Calculator

Create `lib/utils/helpers/spaced_repetition_calculator.dart`:

```dart
import '../../domain/entities/enums.dart';

class SpacedRepetitionCalculator {
  static const List<int> intervals = [1, 3, 7, 14, 30, 60, 180]; // days

  static DateTime calculateNextReviewDate({
    required DateTime lastReviewDate,
    required int timesReviewed,
    required ReviewRating rating,
  }) {
    int intervalIndex = timesReviewed.clamp(0, intervals.length - 1);
    int baseDays = intervals[intervalIndex];

    double factor = 1.0;
    int adjustment = 0;

    switch (rating) {
      case ReviewRating.hard:
        factor = 0.5;
        adjustment = -1;
      case ReviewRating.good:
        factor = 1.0;
        adjustment = 0;
      case ReviewRating.easy:
        factor = 1.3;
        adjustment = 1;
    }

    // Adjust interval index
    intervalIndex = (intervalIndex + adjustment).clamp(0, intervals.length - 1);
    baseDays = intervals[intervalIndex];

    int daysToAdd = (baseDays * factor).toInt().clamp(1, 365);
    return lastReviewDate.add(Duration(days: daysToAdd));
  }

  static double calculateMasteryLevel({
    required double currentMastery,
    required ReviewRating rating,
  }) {
    switch (rating) {
      case ReviewRating.hard:
        return (currentMastery - 0.15).clamp(0.0, 1.0);
      case ReviewRating.good:
        return (currentMastery + 0.05).clamp(0.0, 1.0);
      case ReviewRating.easy:
        return (currentMastery + 0.2).clamp(0.0, 1.0);
    }
  }
}
```

### Step 4.2: Date Helper

Create `lib/utils/helpers/date_helper.dart`:

```dart
class DateHelper {
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 7));
    return date.isAfter(weekStart) && date.isBefore(weekEnd);
  }

  static bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  static String daysUntilReview(DateTime nextReviewDate) {
    final now = DateTime.now();
    final difference = nextReviewDate.difference(now);

    if (difference.inDays < 0) {
      return 'Due now!';
    } else if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else {
      return 'In ${difference.inDays} days';
    }
  }
}
```

### Step 4.3: Logger

Create `lib/core/logger.dart`:

```dart
enum LogLevel { debug, info, warning, error }

class AppLogger {
  static void log(
    String message, {
    LogLevel level = LogLevel.info,
    StackTrace? stackTrace,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    final prefix = level.toString().split('.').last.toUpperCase();

    print('[$timestamp] [$prefix] $message');

    if (stackTrace != null) {
      print(stackTrace);
    }
  }

  static void debug(String message) => log(message, level: LogLevel.debug);
  static void info(String message) => log(message, level: LogLevel.info);
  static void warning(String message) => log(message, level: LogLevel.warning);
  static void error(String message, {StackTrace? stackTrace}) =>
      log(message, level: LogLevel.error, stackTrace: stackTrace);
}
```

---

## DAY 5: DATA LAYER REPOSITORIES

### Step 5.1: Concept Repository Implementation

Create `lib/data/repositories/concept_repository_impl.dart`:

```dart
import 'dart:convert';
import '../../domain/entities/concept.dart';
import '../../domain/entities/enums.dart';
import '../../domain/repositories/concept_repository.dart';
import '../../utils/helpers/spaced_repetition_calculator.dart';
import '../local/database/app_database.dart';
import '../local/mappers/concept_mapper.dart';

class ConceptRepositoryImpl implements ConceptRepository {
  final AppDatabase _database;

  ConceptRepositoryImpl(this._database);

  @override
  Future<List<Concept>> getAllConcepts() async {
    final rows = await _database.select(_database.conceptsTable).get();
    return rows.map((row) => _rowToConcept(row)).toList();
  }

  @override
  Future<Concept?> getConceptById(String id) async {
    final row = await (_database.select(_database.conceptsTable)
          ..where((c) => c.id.equals(id)))
        .getSingleOrNull();
    return row != null ? _rowToConcept(row) : null;
  }

  @override
  Future<List<Concept>> getConceptsDueForReview() async {
    final rows = await _database.getConceptsDueForReview();
    return rows.map((row) => _rowToConcept(row)).toList();
  }

  @override
  Future<List<Concept>> getConceptsByCategory(ConceptCategory category) async {
    final rows = await _database.getConceptsByCategory(category.name);
    return rows.map((row) => _rowToConcept(row)).toList();
  }

  @override
  Future<List<Concept>> searchConcepts(String query) async {
    final rows = await _database.searchConcepts(query);
    return rows.map((row) => _rowToConcept(row)).toList();
  }

  @override
  Future<void> createConcept(Concept concept) async {
    final row = ConceptsTableCompanion(
      id: Value(concept.id),
      title: Value(concept.title),
      description: Value(concept.description),
      category: Value(concept.category.name),
      difficulty: Value(concept.difficulty.name),
      tags: Value(jsonEncode(concept.tags)),
      notes: Value(concept.notes),
      keyTakeaways: Value(jsonEncode(concept.keyTakeaways)),
      createdAt: Value(concept.createdAt),
      lastRevisedAt: Value(concept.lastRevisedAt),
      nextReviewDate: Value(concept.nextReviewDate),
      codeSnippetsIds: Value(jsonEncode(concept.codeSnippetsIds)),
      relatedConceptIds: Value(jsonEncode(concept.relatedConceptIds)),
      problemsIds: Value(jsonEncode(concept.problemsIds)),
      learningStatus: Value(concept.learningStatus.name),
      masteryLevel: Value(concept.masteryLevel),
      timesReviewed: Value(concept.timesReviewed),
      averageRating: Value(concept.averageRating),
      interviewRelevance: Value(concept.interviewRelevance),
      interviewFrequency: Value(concept.interviewFrequency),
    );

    await _database.into(_database.conceptsTable).insert(row);
  }

  @override
  Future<void> updateConcept(Concept concept) async {
    final row = ConceptsTableCompanion(
      id: Value(concept.id),
      title: Value(concept.title),
      description: Value(concept.description),
      category: Value(concept.category.name),
      difficulty: Value(concept.difficulty.name),
      tags: Value(jsonEncode(concept.tags)),
      notes: Value(concept.notes),
      keyTakeaways: Value(jsonEncode(concept.keyTakeaways)),
      lastRevisedAt: Value(concept.lastRevisedAt),
      nextReviewDate: Value(concept.nextReviewDate),
      codeSnippetsIds: Value(jsonEncode(concept.codeSnippetsIds)),
      relatedConceptIds: Value(jsonEncode(concept.relatedConceptIds)),
      problemsIds: Value(jsonEncode(concept.problemsIds)),
      learningStatus: Value(concept.learningStatus.name),
      masteryLevel: Value(concept.masteryLevel),
      timesReviewed: Value(concept.timesReviewed),
      averageRating: Value(concept.averageRating),
      interviewRelevance: Value(concept.interviewRelevance),
      interviewFrequency: Value(concept.interviewFrequency),
    );

    await _database.update(_database.conceptsTable).replace(row);
  }

  @override
  Future<void> deleteConcept(String id) async {
    await (_database.delete(_database.conceptsTable)
          ..where((c) => c.id.equals(id)))
        .go();
  }

  @override
  Future<void> updateReviewDate({
    required String conceptId,
    required ReviewRating rating,
  }) async {
    final concept = await getConceptById(conceptId);
    if (concept == null) return;

    final nextReviewDate = SpacedRepetitionCalculator.calculateNextReviewDate(
      lastReviewDate: concept.lastRevisedAt,
      timesReviewed: concept.timesReviewed,
      rating: rating,
    );

    final newMasteryLevel = SpacedRepetitionCalculator.calculateMasteryLevel(
      currentMastery: concept.masteryLevel,
      rating: rating,
    );

    final updated = concept.copyWith(
      lastRevisedAt: DateTime.now(),
      nextReviewDate: nextReviewDate,
      masteryLevel: newMasteryLevel,
      timesReviewed: concept.timesReviewed + 1,
    );

    await updateConcept(updated);
  }

  Concept _rowToConcept(ConceptsTableData row) {
    return Concept(
      id: row.id,
      title: row.title,
      description: row.description,
      category: ConceptCategory.fromString(row.category),
      difficulty: DifficultyLevel.fromString(row.difficulty),
      tags: List<String>.from(jsonDecode(row.tags) as List? ?? []),
      notes: row.notes,
      keyTakeaways: List<String>.from(jsonDecode(row.keyTakeaways) as List? ?? []),
      createdAt: row.createdAt,
      lastRevisedAt: row.lastRevisedAt,
      nextReviewDate: row.nextReviewDate,
      codeSnippetsIds: List<String>.from(jsonDecode(row.codeSnippetsIds) as List? ?? []),
      relatedConceptIds: List<String>.from(jsonDecode(row.relatedConceptIds) as List? ?? []),
      problemsIds: List<String>.from(jsonDecode(row.problemsIds) as List? ?? []),
      learningStatus: LearningStatus.fromString(row.learningStatus),
      masteryLevel: row.masteryLevel,
      timesReviewed: row.timesReviewed,
      averageRating: row.averageRating,
      interviewRelevance: row.interviewRelevance,
      interviewFrequency: row.interviewFrequency,
    );
  }
}
```

Create similar implementation files for other repositories.

### Step 5.2: Update main.dart

Create `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning Hub',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(
          child: Text('Flutter Learning Hub - Week 1 Complete!'),
        ),
      ),
    );
  }
}
```

---

## FINAL STEP: RUN & VERIFY

```bash
cd ~/projects/flutter_learning_hub

# Clean
flutter clean

# Get dependencies
flutter pub get

# Generate all code
flutter pub run build_runner build --delete-conflicting-outputs

# Run
flutter run
```

**Expected Output:**
- No compilation errors
- App launches and shows "Flutter Learning Hub - Week 1 Complete!"
- Database is created in app's directory

---

## WEEK 1 CHECKLIST

- [ ] Project created with all dependencies
- [ ] Directory structure fully organized
- [ ] All enums defined
- [ ] All domain entities created with Freezed
- [ ] All Drift tables created
- [ ] Main database file with custom queries
- [ ] Spaced repetition calculator complete
- [ ] Date helper utilities complete
- [ ] All abstract repositories defined
- [ ] Concept repository fully implemented
- [ ] Code generation successful (no errors)
- [ ] App compiles and runs

**If you get stuck:**
1. Check dependency versions match exactly
2. Run `flutter pub get` before code generation
3. Check for typos in entity/table names
4. Make sure all imports are correct

**Next:** Week 2 will build the UI layer on top of this foundation.
