# Flutter Learning & Interview Prep Platform
## Complete Architecture & Execution Roadmap

**Project Scope:** Personal Flutter learning app with concepts, interview prep, quizzes, code snippets, problem tracking, and progress analytics.

**Timeline:** 8 weeks to production-ready MVP

**Stack:**
- Frontend: Flutter + Dart
- State Management: Riverpod
- Local Database: SQLite + Drift
- Navigation: Go Router
- UI Components: Flutter Material 3 + custom widgets
- Rich Text: Markdown + syntax highlighting

---

## SECTION 1: DATA MODEL & DOMAIN LAYER

### 1.1 Entity Definitions

```
User {
  id: String (UUID)
  createdAt: DateTime
  totalConceptsLearned: int
  totalQuizzesTaken: int
  currentStreak: int
  longestStreak: int
}

Concept {
  id: String (UUID)
  title: String
  description: String
  category: ConceptCategory (UI, StateManagement, Navigation, Performance, etc.)
  difficulty: DifficultyLevel (Beginner, Intermediate, Advanced)
  tags: List<String>
  
  notes: String (Markdown)
  keyTakeaways: List<String>
  
  createdAt: DateTime
  lastRevisedAt: DateTime
  nextReviewDate: DateTime (for spaced repetition)
  
  codeSnippetsIds: List<String>
  relatedConceptIds: List<String>
  problemsIds: List<String>
  
  learningStatus: LearningStatus (NotStarted, Learning, Mastered, Revisiting)
  masteryLevel: double (0.0 - 1.0) // Updated on review
  timesReviewed: int
  averageRating: double (1-5)
  
  interviewRelevance: bool
  interviewFrequency: String (Rare, Sometimes, Frequently)
}

CodeSnippet {
  id: String (UUID)
  conceptId: String (FK)
  title: String
  language: String (always "dart" for this app)
  code: String
  explanation: String (Markdown)
  useCases: List<String>
  gotchas: List<String>
  tags: List<String>
  createdAt: DateTime
}

Problem {
  id: String (UUID)
  title: String
  description: String (Markdown)
  context: String (what were you building?)
  
  solution: String (Markdown)
  solutionApproaches: List<String> // Multiple approaches to solve
  
  conceptsLinked: List<String> (FK to Concept)
  codeSnippetId: String (optional, FK)
  
  dateEncountered: DateTime
  dateSolved: DateTime
  status: ProblemStatus (Unsolved, Solved, PartiaySolved)
  tags: List<String>
  
  priority: PriorityLevel (Low, Medium, High, Critical)
  frequency: int // How many times encountered
}

Quiz {
  id: String (UUID)
  title: String
  description: String
  difficulty: DifficultyLevel
  category: ConceptCategory
  
  questionsIds: List<String>
  timeLimit: int? (in minutes, optional)
  passingScore: double (0.0 - 1.0)
  
  createdAt: DateTime
  updatedAt: DateTime
}

QuizQuestion {
  id: String (UUID)
  quizId: String (FK)
  conceptId: String (FK)
  
  question: String
  questionType: QuestionType (MultipleChoice, CodeCompletion, TrueFalse)
  
  options: List<QuizOption> // For multiple choice
  correctAnswerId: String
  
  explanation: String (Markdown)
  hints: List<String>
  
  difficulty: DifficultyLevel
  timeLimit: int? (seconds, optional)
}

QuizOption {
  id: String (UUID)
  text: String
  isCorrect: bool
}

QuizAttempt {
  id: String (UUID)
  quizId: String (FK)
  
  startedAt: DateTime
  completedAt: DateTime
  score: double (0.0 - 1.0)
  passed: bool
  
  answers: Map<String, String> // questionId -> selectedOptionId
  correctAnswersCount: int
  totalQuestionsCount: int
  timeTaken: int (seconds)
  
  conceptsReviewNeeded: List<String> // Concepts user got wrong
}

DailyProgress {
  id: String (UUID)
  date: DateTime
  
  conceptsLearned: int
  conceptsRevisited: int
  quizzesTaken: int
  averageQuizScore: double
  
  codeSnippetsAdded: int
  problemsSolved: int
  totalTimeSpent: int (minutes)
}

InterviewQuestion {
  id: String (UUID)
  question: String
  category: String (e.g., "State Management", "Performance", "Design Patterns")
  difficulty: DifficultyLevel
  
  keyPoints: List<String>
  sampleAnswer: String (Markdown)
  commonMistakes: List<String>
  relatedConcepts: List<String> (FK)
  
  frequency: String (Asked often, Sometimes, Rarely)
}

InterviewAttempt {
  id: String (UUID)
  questionId: String (FK)
  
  userAnswer: String
  dateAnswered: DateTime
  rating: int (1-5) // How well did you answer
  
  notes: String // Your reflection on the answer
}
```

### 1.2 Enums

```dart
enum ConceptCategory {
  ui,
  stateManagement,
  navigation,
  performance,
  asynchronous,
  testing,
  architecture,
  designPatterns,
  bestPractices,
  advanced,
  packages,
}

enum DifficultyLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

enum LearningStatus {
  notStarted,
  learning,
  mastered,
  revisiting,
}

enum QuestionType {
  multipleChoice,
  codeCompletion,
  trueFalse,
}

enum ProblemStatus {
  unsolved,
  solved,
  partiallySolved,
}

enum PriorityLevel {
  low,
  medium,
  high,
  critical,
}
```

---

## SECTION 2: TECH STACK & PROJECT SETUP

### 2.1 Dependencies

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

  # UI & Styling
  flutter_markdown: ^0.6.0
  highlight: ^0.7.0
  intl: ^0.19.0

  # Utils
  uuid: ^4.0.0
  freezed_annotation: ^2.4.0
  json_serializable: ^6.7.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.0
  build_runner: ^2.4.0
  drift_dev: ^2.14.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  riverpod_generator: ^2.3.0
```

### 2.2 Directory Structure

```
flutter_learning_hub/
├── lib/
│   ├── main.dart
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_strings.dart
│   │   │   ├── app_colors.dart
│   │   │   └── app_sizes.dart
│   │   ├── extensions/
│   │   │   ├── date_extensions.dart
│   │   │   └── string_extensions.dart
│   │   └── theme/
│   │       └── app_theme.dart
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── concept.dart
│   │   │   ├── code_snippet.dart
│   │   │   ├── problem.dart
│   │   │   ├── quiz.dart
│   │   │   ├── quiz_attempt.dart
│   │   │   ├── interview_question.dart
│   │   │   ├── daily_progress.dart
│   │   │   └── user.dart
│   │   └── repositories/
│   │       ├── concept_repository.dart
│   │       ├── quiz_repository.dart
│   │       ├── problem_repository.dart
│   │       ├── interview_repository.dart
│   │       └── progress_repository.dart
│   │
│   ├── data/
│   │   ├── local/
│   │   │   ├── database/
│   │   │   │   ├── app_database.dart (Drift database)
│   │   │   │   ├── migrations/
│   │   │   │   │   └── migration_1.dart
│   │   │   │   └── tables/
│   │   │   │       ├── concepts_table.dart
│   │   │   │       ├── code_snippets_table.dart
│   │   │   │       ├── problems_table.dart
│   │   │   │       ├── quizzes_table.dart
│   │   │   │       ├── quiz_questions_table.dart
│   │   │   │       ├── quiz_attempts_table.dart
│   │   │   │       ├── interview_questions_table.dart
│   │   │   │       ├── interview_attempts_table.dart
│   │   │   │       └── daily_progress_table.dart
│   │   │   └── mappers/
│   │   │       ├── concept_mapper.dart
│   │   │       ├── quiz_mapper.dart
│   │   │       └── problem_mapper.dart
│   │   └── repositories/
│   │       ├── concept_repository_impl.dart
│   │       ├── quiz_repository_impl.dart
│   │       ├── problem_repository_impl.dart
│   │       ├── interview_repository_impl.dart
│   │       └── progress_repository_impl.dart
│   │
│   ├── presentation/
│   │   ├── providers/
│   │   │   ├── concept_providers.dart
│   │   │   ├── quiz_providers.dart
│   │   │   ├── problem_providers.dart
│   │   │   ├── interview_providers.dart
│   │   │   ├── progress_providers.dart
│   │   │   ├── navigation_provider.dart
│   │   │   └── theme_provider.dart
│   │   │
│   │   ├── screens/
│   │   │   ├── home/
│   │   │   │   └── home_screen.dart
│   │   │   ├── concepts/
│   │   │   │   ├── concepts_list_screen.dart
│   │   │   │   ├── concept_detail_screen.dart
│   │   │   │   ├── create_concept_screen.dart
│   │   │   │   └── edit_concept_screen.dart
│   │   │   ├── quizzes/
│   │   │   │   ├── quizzes_list_screen.dart
│   │   │   │   ├── quiz_detail_screen.dart
│   │   │   │   ├── quiz_play_screen.dart
│   │   │   │   └── quiz_result_screen.dart
│   │   │   ├── problems/
│   │   │   │   ├── problems_list_screen.dart
│   │   │   │   ├── problem_detail_screen.dart
│   │   │   │   └── create_problem_screen.dart
│   │   │   ├── interview/
│   │   │   │   ├── interview_questions_screen.dart
│   │   │   │   ├── interview_question_detail_screen.dart
│   │   │   │   └── interview_practice_screen.dart
│   │   │   ├── review/
│   │   │   │   ├── review_queue_screen.dart
│   │   │   │   └── review_card_screen.dart
│   │   │   ├── progress/
│   │   │   │   ├── progress_dashboard_screen.dart
│   │   │   │   ├── stats_screen.dart
│   │   │   │   └── calendar_heatmap_screen.dart
│   │   │   ├── search/
│   │   │   │   └── search_screen.dart
│   │   │   └── settings/
│   │   │       └── settings_screen.dart
│   │   │
│   │   ├── widgets/
│   │   │   ├── common/
│   │   │   │   ├── app_bar_custom.dart
│   │   │   │   ├── bottom_nav_bar.dart
│   │   │   │   ├── loading_widget.dart
│   │   │   │   ├── error_widget.dart
│   │   │   │   └── empty_state_widget.dart
│   │   │   ├── cards/
│   │   │   │   ├── concept_card.dart
│   │   │   │   ├── quiz_card.dart
│   │   │   │   ├── problem_card.dart
│   │   │   │   └── code_snippet_card.dart
│   │   │   ├── forms/
│   │   │   │   ├── concept_form.dart
│   │   │   │   ├── problem_form.dart
│   │   │   │   └── quiz_form.dart
│   │   │   ├── display/
│   │   │   │   ├── markdown_viewer.dart
│   │   │   │   ├── code_viewer.dart
│   │   │   │   └── syntax_highlighter.dart
│   │   │   └── interactive/
│   │   │       ├── spaced_repetition_card.dart
│   │   │       ├── quiz_question_widget.dart
│   │   │       ├── rating_widget.dart
│   │   │       └── difficulty_selector.dart
│   │   │
│   │   └── router/
│   │       ├── app_router.dart
│   │       └── route_names.dart
│   │
│   └── utils/
│       ├── logger.dart
│       ├── helpers/
│       │   ├── date_helper.dart
│       │   ├── spaced_repetition_calculator.dart
│       │   ├── markdown_parser.dart
│       │   └── search_helper.dart
│       └── formatters/
│           ├── duration_formatter.dart
│           └── date_formatter.dart
│
├── test/
│   ├── domain/
│   │   └── repositories/
│   │       ├── concept_repository_test.dart
│   │       └── quiz_repository_test.dart
│   ├── data/
│   │   └── local/
│   │       └── database_test.dart
│   └── presentation/
│       └── widgets/
│           └── concept_card_test.dart
│
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

---

## SECTION 3: CORE FEATURES & FUNCTIONALITY

### 3.1 Feature Set

#### Tier 1 (MVP - Weeks 1-4)
1. **Concept Management**
   - Create concept (title, description, category, difficulty, tags)
   - View concept list with search & filter
   - View concept details (notes, snippets, related concepts)
   - Edit/delete concept
   - Add/manage code snippets within concept

2. **Spaced Repetition Review**
   - Review queue (concepts due for review)
   - Quick review card (concept + rating easy/good/hard)
   - Update mastery level based on rating
   - Automatic next review date calculation

3. **Code Snippet Management**
   - Attach Dart code to concepts
   - Syntax highlighting
   - Copy to clipboard
   - Tag snippets for searching

4. **Basic Progress Tracking**
   - Total concepts learned count
   - Last revision dates
   - Learning status (NotStarted → Learning → Mastered)

#### Tier 2 (Weeks 5-6)
5. **Quiz System**
   - Create custom quizzes (multiple choice)
   - Take quizzes with timer
   - Quiz results with score
   - Review incorrect answers
   - Quiz attempts tracking

6. **Problem Tracking**
   - Create problem (title, description, solution)
   - Link problems to concepts
   - Track problem status (unsolved/solved)
   - Search problems by tag/concept

7. **Interview Prep**
   - Interview question bank (seeded by you)
   - Question difficulty levels
   - Practice mode (answer questions)
   - Track interview attempts
   - Related concept links

#### Tier 3 (Weeks 7-8)
8. **Advanced Analytics**
   - Progress dashboard (stats, trends)
   - Calendar heatmap (daily activity)
   - Learning streak tracking
   - Concept mastery visualization
   - Time spent per category

9. **Advanced Features**
   - Concept linking (builds on X, relates to Y)
   - Export concept as PDF/Markdown
   - Backup/restore database
   - Dark mode
   - Search across all content

### 3.2 Spaced Repetition Algorithm

```dart
class SpacedRepetitionCalculator {
  static DateTime calculateNextReviewDate({
    required DateTime lastReviewDate,
    required int timesReviewed,
    required ReviewRating rating,
  }) {
    const intervals = [1, 3, 7, 14, 30, 60, 180]; // days
    
    int intervalIndex = timesReviewed.clamp(0, intervals.length - 1);
    int baseDays = intervals[intervalIndex];
    
    double factor = 1.0;
    switch (rating) {
      case ReviewRating.hard:
        factor = 0.5; // Reduce interval
        intervalIndex = (intervalIndex - 1).clamp(0, intervals.length - 1);
        baseDays = intervals[intervalIndex];
      case ReviewRating.good:
        factor = 1.0;
      case ReviewRating.easy:
        factor = 1.25; // Extend interval
    }
    
    int daysToAdd = (baseDays * factor).toInt();
    return lastReviewDate.add(Duration(days: daysToAdd));
  }
}

enum ReviewRating { hard, good, easy }
```

---

## SECTION 4: WEEK-BY-WEEK EXECUTION PLAN

### Week 1: Foundation & Data Layer

**Goal:** Project structure, entities, database schema, initial Riverpod setup

**Tasks:**
- [ ] Create Flutter project with all dependencies
- [ ] Set up directory structure
- [ ] Define all domain entities (freezed)
- [ ] Create Drift database schema & tables
- [ ] Generate code (freezed, drift_dev)
- [ ] Create abstract repositories

**Deliverable:** 
- Fully typed, compiling project
- Database tables created
- No UI yet (just domain & data layers)

**Code to focus on:**
- Clean entity definitions with fromJson/toJson
- Proper database table relationships
- Type-safe repository interfaces

---

### Week 2: Concepts Core Feature

**Goal:** Full CRUD for concepts, basic UI, spaced repetition logic

**Tasks:**
- [ ] Implement concept repository (CRUD operations)
- [ ] Create Riverpod providers for concepts
- [ ] Build home screen (bottom nav, nav structure)
- [ ] Build concepts list screen (search, filter, sort)
- [ ] Build create concept screen
- [ ] Build concept detail screen
- [ ] Implement spaced repetition calculator
- [ ] Build review queue screen

**UI Design Approach:** 
- Minimalist, data-focused (not overly decorative)
- Clear typography hierarchy
- Smart use of color for status indicators
- Smooth transitions between screens

**Deliverable:**
- Fully functional concept CRUD
- Review queue with rating system
- Concepts searchable and filterable by category/difficulty

---

### Week 3: Code Snippets & Problem Tracking

**Goal:** Add code snippets to concepts, create problem tracker

**Tasks:**
- [ ] Implement code snippet repository
- [ ] Add code snippet form to concept creation
- [ ] Build code viewer with syntax highlighting
- [ ] Build problem repository
- [ ] Build problems list screen
- [ ] Build create problem screen
- [ ] Build problem detail screen
- [ ] Link problems to concepts

**Key Implementation:**
- Syntax highlighting using `highlight` package
- Rich markdown rendering for notes
- Proper code copying functionality

**Deliverable:**
- Store & view Dart code with syntax highlighting
- Create/edit problems linked to concepts
- Quick problem reference workflow

---

### Week 4: Quiz System

**Goal:** Build interactive quiz creation and taking experience

**Tasks:**
- [ ] Implement quiz & question repositories
- [ ] Quiz creation form (create quiz, add questions)
- [ ] Quiz play screen (question-by-question, timer, progress)
- [ ] Quiz result screen (score, breakdown, review)
- [ ] Quiz history tracking
- [ ] Link quiz questions to concepts

**Key Implementation:**
- Timer for quizzes
- Question randomization
- Score calculation with percentage
- Instant feedback on answers

**Deliverable:**
- Can create custom quizzes
- Can take quizzes with scoring
- Quiz attempts are tracked

---

### Week 5: Interview Prep Mode

**Goal:** Interview question bank and practice

**Tasks:**
- [ ] Seed interview question database (~100 questions across categories)
- [ ] Build interview questions list screen (categorized)
- [ ] Build interview question detail screen
- [ ] Build interview practice screen (answer + evaluate)
- [ ] Track interview attempt history
- [ ] Link interview questions to concepts

**Seed Data Questions (examples):**
- What's the difference between `StatelessWidget` and `StatefulWidget`?
- Explain the widget lifecycle in Flutter
- How do you handle state in a large app?
- What are BuildContext best practices?
- Performance optimization techniques
- And ~95 more

**Deliverable:**
- Interview question bank
- Practice mode to answer questions
- Track your interview prep progress

---

### Week 6: Analytics & Progress Dashboard

**Goal:** Visualize your learning progress

**Tasks:**
- [ ] Implement daily progress tracking
- [ ] Build progress dashboard screen
- [ ] Stats widgets (concepts learned, quiz scores, streak)
- [ ] Calendar heatmap (daily activity)
- [ ] Category breakdown chart
- [ ] Export progress report

**Analytics to Track:**
- Total concepts learned
- Time spent per category
- Quiz average score
- Review streak
- Mastery distribution
- Most revisited concepts

**Deliverable:**
- Visual progress dashboard
- Stats and trends
- Motivation through streaks

---

### Week 7: Polish & Refinement

**Goal:** Production-quality UX and edge case handling

**Tasks:**
- [ ] Dark mode support
- [ ] Polish all UI (spacing, typography, animations)
- [ ] Add micro-interactions (haptic feedback, smooth transitions)
- [ ] Error handling & empty states
- [ ] Loading states with skeleton loaders
- [ ] Search across all content types
- [ ] Settings screen (theme, notifications preferences)
- [ ] Unit tests for critical business logic

**Key Refinements:**
- Smooth page transitions
- Proper error messages
- Empty state illustrations
- Confirmation dialogs for destructive actions
- Loading skeletons

**Deliverable:**
- Polished, professional app
- Accessible and responsive
- Handles edge cases gracefully

---

### Week 8: Launch & Continuous Improvement

**Goal:** Ready-to-use daily app with feedback loop

**Tasks:**
- [ ] Final bug fixes
- [ ] Performance optimization (if needed)
- [ ] Backup/restore functionality
- [ ] Export/import for sharing
- [ ] Release build (iOS & Android)
- [ ] Document usage for future reference
- [ ] Use app actively for 1 week, note improvements

**Post-Launch Improvements (Based on actual usage):**
- Features you find yourself wishing existed
- UX friction points
- Performance issues
- Missing fields or categories

---

## SECTION 5: CORE IMPLEMENTATION DETAILS

### 5.1 Riverpod Provider Architecture

```dart
// concepts_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'concepts_providers.g.dart';

@riverpod
Future<List<Concept>> allConcepts(AllConceptsRef ref) async {
  final repository = ref.watch(conceptRepositoryProvider);
  return repository.getAllConcepts();
}

@riverpod
Future<Concept?> conceptDetail(ConceptDetailRef ref, String conceptId) async {
  final repository = ref.watch(conceptRepositoryProvider);
  return repository.getConceptById(conceptId);
}

@riverpod
Future<List<Concept>> reviewQueue(ReviewQueueRef ref) async {
  final repository = ref.watch(conceptRepositoryProvider);
  return repository.getConceptsDueForReview();
}

@riverpod
class ConceptFilter extends _$ConceptFilter {
  @override
  ConceptFilterState build() {
    return ConceptFilterState();
  }

  void setCategory(ConceptCategory? category) {
    state = state.copyWith(category: category);
  }

  void setDifficulty(DifficultyLevel? difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

@riverpod
Future<List<Concept>> filteredConcepts(FilteredConceptsRef ref) async {
  final allConcepts = await ref.watch(allConceptsProvider.future);
  final filter = ref.watch(conceptFilterProvider);
  
  return allConcepts
      .where((concept) {
        if (filter.category != null && concept.category != filter.category) {
          return false;
        }
        if (filter.difficulty != null && concept.difficulty != filter.difficulty) {
          return false;
        }
        if (filter.searchQuery.isNotEmpty &&
            !concept.title.toLowerCase().contains(filter.searchQuery.toLowerCase())) {
          return false;
        }
        return true;
      })
      .toList();
}

// Repository provider
@riverpod
ConceptRepository conceptRepository(ConceptRepositoryRef ref) {
  final database = ref.watch(appDatabaseProvider);
  return ConceptRepositoryImpl(database);
}

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  return AppDatabase();
}
```

### 5.2 Database Schema (Drift)

```dart
// app_database.dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('ConceptRow')
class ConceptsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get category => text()(); // ConceptCategory enum
  TextColumn get difficulty => text()(); // DifficultyLevel enum
  TextColumn get tags => text()(); // JSON array as string
  
  TextColumn get notes => text()();
  TextColumn get keyTakeaways => text()(); // JSON array
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastRevisedAt => dateTime()();
  DateTimeColumn get nextReviewDate => dateTime()();
  
  TextColumn get codeSnippetsIds => text()(); // JSON array
  TextColumn get relatedConceptIds => text()(); // JSON array
  TextColumn get problemsIds => text()(); // JSON array
  
  TextColumn get learningStatus => text()(); // LearningStatus enum
  RealColumn get masteryLevel => real()();
  IntColumn get timesReviewed => integer()();
  RealColumn get averageRating => real()();
  
  BoolColumn get interviewRelevance => boolean()();
  TextColumn get interviewFrequency => text()();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CodeSnippetRow')
class CodeSnippetsTable extends Table {
  TextColumn get id => text()();
  TextColumn get conceptId => text()();
  TextColumn get title => text()();
  TextColumn get language => text()();
  TextColumn get code => text()();
  TextColumn get explanation => text()();
  TextColumn get useCases => text()(); // JSON array
  TextColumn get gotchas => text()(); // JSON array
  TextColumn get tags => text()(); // JSON array
  
  DateTimeColumn get createdAt => dateTime()();
  
  @override
  Set<Column> get primaryKey => {id};
  
  @override
  List<Set<Column>> get uniqueKeys => [
    {conceptId, title}
  ];
}

// ... Similar tables for other entities

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
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'flutter_learning_hub');
  }

  // Custom queries for complex operations
  Future<List<ConceptRow>> getConceptsDueForReview() {
    return (select(conceptsTable)
          ..where((c) => c.nextReviewDate.isSmallerThanValue(DateTime.now())))
        .get();
  }

  Future<List<ConceptRow>> getConceptsByCategory(String category) {
    return (select(conceptsTable)
          ..where((c) => c.category.equals(category)))
        .get();
  }
}
```

### 5.3 Repository Implementation

```dart
// concept_repository_impl.dart
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

    double newMasteryLevel = concept.masteryLevel;
    switch (rating) {
      case ReviewRating.hard:
        newMasteryLevel = (concept.masteryLevel - 0.1).clamp(0.0, 1.0);
      case ReviewRating.good:
        newMasteryLevel = (concept.masteryLevel + 0.05).clamp(0.0, 1.0);
      case ReviewRating.easy:
        newMasteryLevel = (concept.masteryLevel + 0.15).clamp(0.0, 1.0);
    }

    final updated = concept.copyWith(
      lastRevisedAt: DateTime.now(),
      nextReviewDate: nextReviewDate,
      masteryLevel: newMasteryLevel,
      timesReviewed: concept.timesReviewed + 1,
    );

    await updateConcept(updated);
  }

  @override
  Future<void> deleteConcept(String id) async {
    await (_database.delete(_database.conceptsTable)
          ..where((c) => c.id.equals(id)))
        .go();
  }

  Concept _rowToConcept(ConceptRow row) {
    return Concept(
      id: row.id,
      title: row.title,
      description: row.description,
      category: ConceptCategory.values.byName(row.category),
      difficulty: DifficultyLevel.values.byName(row.difficulty),
      tags: List<String>.from(jsonDecode(row.tags) as List),
      notes: row.notes,
      keyTakeaways: List<String>.from(jsonDecode(row.keyTakeaways) as List),
      createdAt: row.createdAt,
      lastRevisedAt: row.lastRevisedAt,
      nextReviewDate: row.nextReviewDate,
      codeSnippetsIds: List<String>.from(jsonDecode(row.codeSnippetsIds) as List),
      relatedConceptIds: List<String>.from(jsonDecode(row.relatedConceptIds) as List),
      problemsIds: List<String>.from(jsonDecode(row.problemsIds) as List),
      learningStatus: LearningStatus.values.byName(row.learningStatus),
      masteryLevel: row.masteryLevel,
      timesReviewed: row.timesReviewed,
      averageRating: row.averageRating,
      interviewRelevance: row.interviewRelevance,
      interviewFrequency: row.interviewFrequency,
    );
  }
}
```

---

## SECTION 6: KEY IMPLEMENTATION PATTERNS

### 6.1 Error Handling Pattern

```dart
class Result<T> {
  final T? data;
  final String? error;
  final bool isLoading;

  Result({this.data, this.error, this.isLoading = false});

  factory Result.loading() => Result(isLoading: true);
  factory Result.success(T data) => Result(data: data);
  factory Result.error(String error) => Result(error: error);
}

// Usage in Riverpod:
@riverpod
Future<Result<List<Concept>>> concepts(ConceptsRef ref) async {
  try {
    final repository = ref.watch(conceptRepositoryProvider);
    final data = await repository.getAllConcepts();
    return Result.success(data);
  } catch (e) {
    return Result.error(e.toString());
  }
}
```

### 6.2 Search & Filter Pattern

```dart
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }
}

@riverpod
Future<List<T>> searchResults<T>(
  SearchResultsRef ref,
  List<T> items,
  String Function(T) searchableText,
) async {
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) return items;

  return items
      .where((item) =>
          searchableText(item).toLowerCase().contains(query.toLowerCase()))
      .toList();
}
```

### 6.3 Form Validation Pattern

```dart
class ConceptFormValidator {
  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    if (value.length < 3) {
      return 'Title must be at least 3 characters';
    }
    if (value.length > 100) {
      return 'Title must be less than 100 characters';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }
}
```

---

## SECTION 7: IMPORTANT TECHNICAL DECISIONS

### Decision 1: State Management - Riverpod
**Why:** Immutable, testable, compile-time safe, no BuildContext needed, type-safe.
**Alternative:** BLoC, Provider, GetX
**Tradeoff:** Smaller learning curve than BLoC, but more setup than simple Provider.

### Decision 2: Local Database - Drift
**Why:** Type-safe, migrations, compile-time checking, easy to test, no ORM overhead.
**Alternative:** Hive, ObjectBox, Realm
**Tradeoff:** Bit more verbose than Hive, but way more type-safe.

### Decision 3: Offline-First
**Why:** No server to maintain, instant responses, works without internet.
**Alternative:** Firebase Realtime, Supabase
**Tradeoff:** No cloud sync initially, but can add later without changing app logic.

### Decision 4: Markdown for Notes
**Why:** Simple, readable, renders nicely, version-control friendly.
**Alternative:** Rich Text Editor (Quill, EditorJS)
**Tradeoff:** Less formatting options, but way simpler and cleaner.

---

## SECTION 8: TESTING STRATEGY

### Unit Tests (Domain Layer)
```dart
void main() {
  group('SpacedRepetitionCalculator', () {
    test('should increase interval when user rates easy', () {
      final nextReview = SpacedRepetitionCalculator.calculateNextReviewDate(
        lastReviewDate: DateTime(2024, 1, 1),
        timesReviewed: 1,
        rating: ReviewRating.easy,
      );

      expect(nextReview.isAfter(DateTime(2024, 1, 5)), true);
    });

    test('should decrease interval when user rates hard', () {
      final nextReview = SpacedRepetitionCalculator.calculateNextReviewDate(
        lastReviewDate: DateTime(2024, 1, 1),
        timesReviewed: 3,
        rating: ReviewRating.hard,
      );

      expect(nextReview.isBefore(DateTime(2024, 1, 7)), true);
    });
  });
}
```

### Widget Tests (Presentation Layer)
```dart
void main() {
  group('ConceptCard', () {
    testWidgets('should display concept title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ConceptCard(
              concept: mockConcept,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text(mockConcept.title), findsOneWidget);
    });
  });
}
```

---

## SECTION 9: DEPLOYMENT & RELEASE

### Building for Release

```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
flutter build appbundle --release

# Both
flutter build --release
```

### App Store & Play Store Submission
- Create developer accounts
- Prepare screenshots (6 per platform)
- Write compelling description
- Set up privacy policy
- Submit for review

---

## SECTION 10: POST-LAUNCH ROADMAP

### Phase 2 Features (After MVP validation)
1. Cloud sync with Firebase/Supabase
2. Share concepts as public links
3. Spaced repetition optimization based on data
4. AI-powered quiz generation from notes
5. Voice-to-text concept capture
6. Offline collaborative learning (P2P sync)

### Monetization (if desired)
1. Premium features (advanced analytics, AI quiz generation)
2. Paid templates and curated concept packs
3. Coaching marketplace integration

---

## FINAL NOTES

**This roadmap is NOT set in stone.** After Week 4, you'll have real usage data. Adjust based on:
- What you actually use daily
- What features save you the most time
- Where you encounter friction

**Success metrics:**
- Using the app 5+ days/week
- Adding 5+ new concepts/week
- Taking quizzes weekly
- Review streaks lasting 30+ days
- Measurable improvement in Flutter knowledge

**Documentation to maintain:**
- API endpoint decisions
- Data model rationale
- UI/UX decisions and why
- Performance optimizations attempted

Start Week 1 immediately. Build, use, iterate.

---

**Questions before we dive into Week 1 code?**
