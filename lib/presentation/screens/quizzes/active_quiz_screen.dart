import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_shadows.dart';

enum QuizType { codeCompletion, multipleChoice, visualLogic, success }

class ActiveQuizScreen extends StatefulWidget {
  const ActiveQuizScreen({super.key});

  @override
  State<ActiveQuizScreen> createState() => _ActiveQuizScreenState();
}

class _ActiveQuizScreenState extends State<ActiveQuizScreen> {
  int _currentIndex = 0;
  QuizType _currentType = QuizType.codeCompletion;
  
  // State for Code Completion
  final List<String?> _codeBlanks = [null, null];
  
  // State for Multiple Choice
  int _selectedOptionIndex = -1;

  final List<String> _dragOptions = ['dispose()', 'setState()', 'didUpdateWidget()'];

  double get _progress => (_currentIndex + 1) / 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuestionHeader(),
                    const SizedBox(height: 24),
                    _buildDynamicContent(),
                    const SizedBox(height: 32),
                    if (_currentType == QuizType.codeCompletion) _buildSelectionArea(),
                    const SizedBox(height: 32),
                    if (_currentType == QuizType.codeCompletion) _buildLogicHint(),
                    if (_currentType == QuizType.multipleChoice) _buildMultipleChoiceOptions(),
                    if (_currentType == QuizType.visualLogic) _buildMultipleChoiceOptions(),
                  ],
                ),
              ),
            ),
            if (_currentType != QuizType.success) _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.2))),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close_rounded, color: AppColors.onSurfaceVariant),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '${(_progress * 100).toInt()}% MASTERY',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 6,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _buildTimer(),
        ],
      ),
    );
  }

  Widget _buildTimer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, size: 16, color: AppColors.error),
          const SizedBox(width: 6),
          Text(
            '01:45',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader() {
    String category = 'FLUTTER MASTERY';
    String questionNum = 'QUESTION 08';
    String question = 'Complete the Widget lifecycle sequence for a Stateful Widget.';

    if (_currentType == QuizType.multipleChoice) {
      category = 'STATE MANAGEMENT';
      questionNum = 'QUESTION 04 OF 12';
      question = 'Identify the correct way to handle a nullable value in this Flutter Widget tree state.';
    } else if (_currentType == QuizType.visualLogic) {
      category = 'ADVANCED RECONCILIATION';
      questionNum = 'QUESTION 13/20';
      question = 'Identify the breaking point in this widget tree reconciliation.';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionNum.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          question,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicContent() {
    switch (_currentType) {
      case QuizType.codeCompletion:
        return _buildCodeCompletionCard();
      case QuizType.multipleChoice:
        return Column(
          children: [
            _buildCodeSnippetCard(),
            const SizedBox(height: 24),
            _buildLogicFlowVisual(),
          ],
        );
      case QuizType.visualLogic:
        return _buildVisualTreeDiagram();
      case QuizType.success:
        return _buildSuccessView();
    }
  }

  Widget _buildCodeSnippetCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.premium,
      ),
      child: Column(
        children: [
          _buildCodeEditorHeader('lib/main.dart'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'class UserCard extends StatelessWidget {\n  final String? username;\n\n  UserCard({this.username});\n\n  @override\n  Widget build(BuildContext context) {\n    return Text(\n      username ?? \'Guest\',\n      style: TextStyle(fontSize: 20),\n    );\n  }\n}',
              style: GoogleFonts.spaceGrotesk(color: Colors.white70, fontSize: 13, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogicFlowVisual() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LOGIC FLOW VISUALIZATION',
          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.outline, letterSpacing: 1),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFlowNode('Null\nCheck', true),
              const SizedBox(width: 12),
              Column(
                children: [
                  Text('True', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.outline, decoration: TextDecoration.underline)),
                  const Icon(Icons.arrow_forward, size: 16, color: AppColors.outlineVariant),
                ],
              ),
              const SizedBox(width: 12),
              _buildFlowNode('Default\nValue', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlowNode(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFFD1EFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? AppColors.primary : const Color(0xFF00687A).withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isActive ? AppColors.primary : const Color(0xFF006172),
        ),
      ),
    );
  }

  Widget _buildVisualTreeDiagram() {
    return Container(
      width: double.infinity,
      height: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: AppShadows.soft,
      ),
      child: Stack(
        children: [
          Center(
            child: CustomPaint(
              size: const Size(double.infinity, 240),
              painter: TreePainter(),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDDB8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppShadows.soft,
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb_outline, size: 16, color: Color(0xFF684000)),
                  const SizedBox(width: 6),
                  Text('Hint', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF684000))),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFF904900), borderRadius: BorderRadius.circular(4)),
                    child: Text('-50 XP', style: GoogleFonts.inter(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceOptions() {
    final options = [
      'Use the null-aware assignment operator (??=) to modify the username before rendering.',
      'Implement the null-coalescing operator (??) to provide a fallback value \'Guest\'.',
      'Wrap the Text widget in a NullHandler parent widget to safely unwrap the string.',
      'Convert the Widget to a StatefulWidget and check for null in the initState method.'
    ];

    return Column(
      children: List.generate(options.length, (index) {
        final letter = String.fromCharCode(65 + index);
        final isSelected = _selectedOptionIndex == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedOptionIndex = index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.outlineVariant.withValues(alpha: 0.3),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    letter,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    options[index],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ),
                if (isSelected) const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCodeCompletionCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCodeEditorHeader(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCodeLine(1, 'initState', '()'),
                const SizedBox(height: 16),
                _buildCodeLine(2, 'didChangeDependencies', '()'),
                const SizedBox(height: 16),
                _buildCodeLineWithBlank(3, 0),
                const SizedBox(height: 16),
                _buildCodeLine(4, 'build', '()'),
                const SizedBox(height: 16),
                _buildCodeLineWithBlank(5, 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeEditorHeader([String filename = 'main_state.dart']) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Row(
            children: [
              _buildCircle(Colors.red.shade400),
              const SizedBox(width: 6),
              _buildCircle(Colors.amber.shade400),
              const SizedBox(width: 6),
              _buildCircle(Colors.green.shade400),
            ],
          ),
          const Spacer(),
          Text(
            filename,
            style: GoogleFonts.inter(fontSize: 11, color: Colors.white38),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.copy_rounded, size: 14, color: Colors.white24),
        ],
      ),
    );
  }

  Widget _buildCircle(Color color) => Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle));

  Widget _buildCodeLine(int line, String method, String suffix) {
    return Row(
      children: [
        SizedBox(width: 24, child: Text('$line', style: GoogleFonts.spaceGrotesk(color: Colors.white12, fontSize: 14))),
        const SizedBox(width: 12),
        Text(
          method,
          style: GoogleFonts.spaceGrotesk(color: const Color(0xFFF472B6), fontSize: 15, fontWeight: FontWeight.w500),
        ),
        Text(
          suffix,
          style: GoogleFonts.spaceGrotesk(color: Colors.white70, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildCodeLineWithBlank(int line, int blankIndex) {
    final value = _codeBlanks[blankIndex];
    return Row(
      children: [
        SizedBox(width: 24, child: Text('$line', style: GoogleFonts.spaceGrotesk(color: Colors.white12, fontSize: 14))),
        const SizedBox(width: 12),
        Expanded(
          child: DragTarget<String>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                height: 44,
                decoration: BoxDecoration(
                  color: value != null ? AppColors.primary.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: value != null ? AppColors.primary : Colors.white12,
                    style: value != null ? BorderStyle.solid : BorderStyle.none,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  value ?? '[ ____ Blank ____ ]',
                  style: GoogleFonts.spaceGrotesk(
                    color: value != null ? Colors.white : Colors.white24,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            onAcceptWithDetails: (details) {
              setState(() {
                _codeBlanks[blankIndex] = details.data;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select lifecycle methods:',
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.onSurface),
            ),
            Text(
              'Tap or Drag',
              style: GoogleFonts.inter(fontSize: 12, color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _dragOptions.map((option) => _buildDraggableOption(option)).toList(),
        ),
      ],
    );
  }

  Widget _buildDraggableOption(String option) {
    final isUsed = _codeBlanks.contains(option);
    return Draggable<String>(
      data: option,
      feedback: Material(
        color: Colors.transparent,
        child: _buildOptionContent(option, true),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: _buildOptionContent(option, false)),
      child: Opacity(opacity: isUsed ? 0.3 : 1.0, child: _buildOptionContent(option, false)),
    );
  }

  Widget _buildOptionContent(String text, bool isFloating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.4)),
        boxShadow: isFloating ? AppShadows.premium : AppShadows.soft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.drag_indicator_rounded, size: 16, color: AppColors.outline),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogicHint() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: AppShadows.soft),
            child: const Icon(Icons.lightbulb_outline_rounded, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lifecycle Logic',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(fontSize: 13, color: AppColors.onSurfaceVariant, height: 1.5),
                    children: const [
                      TextSpan(text: 'Remember that '),
                      TextSpan(text: 'didUpdateWidget', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                      TextSpan(text: ' is triggered whenever the parent widget rebuilds and passes new data.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.2))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: AppColors.surfaceContainerHigh,
              ),
              child: Text(
                'Skip',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: AppColors.onSurfaceVariant),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_currentIndex < 2) {
                      _currentIndex++;
                      if (_currentIndex == 1) _currentType = QuizType.multipleChoice;
                      if (_currentIndex == 2) _currentType = QuizType.visualLogic;
                    } else {
                      _currentType = QuizType.success;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_currentIndex < 2 ? 'Next Question' : 'Finish Quiz', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      children: [
        const SizedBox(height: 40),
        // Celebratory Icon/Animation
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF4F46E5), Color(0xFF818CF8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 60),
        ),
        const SizedBox(height: 32),
        Text(
          'Quiz Completed!',
          style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.onSurface),
        ),
        const SizedBox(height: 8),
        Text(
          'You are mastering Flutter at a rapid pace.',
          style: GoogleFonts.inter(fontSize: 16, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 40),
        // Score Cards Grid
        Row(
          children: [
            _buildScoreCard('SCORE', '12/12', Colors.green, Icons.check_circle_outline),
            const SizedBox(width: 16),
            _buildScoreCard('XP EARNED', '+850', Colors.amber, Icons.bolt_rounded),
          ],
        ),
        const SizedBox(height: 16),
        _buildMasteryStats(),
        const SizedBox(height: 48),
        // Success Actions
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text('Back to Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: Text(
            'Review Answers',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(String label, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: color, letterSpacing: 1),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.onSurface),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMasteryStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.auto_graph_rounded, color: Colors.green, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mastery Increased!',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
                Text(
                  'Your level in Flutter UI jumped to Level 14.',
                  style: GoogleFonts.inter(fontSize: 13, color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.outlineVariant.withValues(alpha: 0.4)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()..style = PaintingStyle.fill;
    
    // Draw connections
    canvas.drawLine(Offset(size.width / 2, 40), Offset(size.width / 2, 80), paint);
    canvas.drawLine(Offset(size.width / 2, 120), Offset(size.width / 4, 160), paint);
    canvas.drawLine(Offset(size.width / 2, 120), Offset(size.width / 2, 160), paint);
    
    final dashedPaint = Paint()
      ..color = AppColors.error
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    // Dashed line for error
    canvas.drawLine(Offset(size.width / 2, 120), Offset(size.width * 3 / 4, 160), dashedPaint);

    // Draw Nodes (Simplified)
    _drawNode(canvas, Offset(size.width / 2, 40), 'Scaffold', const Color(0xFF4648D4), Colors.white);
    _drawNode(canvas, Offset(size.width / 2, 100), 'Column', const Color(0xFF00687A), Colors.white);
    _drawNode(canvas, Offset(size.width / 4, 180), 'Icon', const Color(0xFFE9E6F3), AppColors.onSurface);
    _drawNode(canvas, Offset(size.width / 2, 180), 'Text', const Color(0xFFE9E6F3), AppColors.onSurface);
    _drawNode(canvas, Offset(size.width * 3 / 4, 180), 'SizedBox', const Color(0xFFFFDAD6), AppColors.error, true);
  }

  void _drawNode(Canvas canvas, Offset center, String text, Color color, Color textColor, [bool hasError = false]) {
    final rect = Rect.fromCenter(center: center, width: 80, height: 36);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(6));
    
    final paint = Paint()..color = color;
    canvas.drawRRect(rrect, paint);
    
    if (hasError) {
      final borderPaint = Paint()
        ..color = AppColors.error
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawRRect(rrect, borderPaint);
      
      // Error exclamation
      final circlePaint = Paint()..color = AppColors.error;
      canvas.drawCircle(Offset(center.dx + 40, center.dy - 18), 8, circlePaint);
    }

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: GoogleFonts.inter(fontSize: 10, color: textColor, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
