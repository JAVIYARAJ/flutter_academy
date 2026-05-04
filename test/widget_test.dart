import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_lab/app.dart';

void main() {
  testWidgets('app boots into placeholder route', (tester) async {
    await tester.pumpWidget(const FlutterLearningApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter Learning Hub'), findsOneWidget);
    expect(find.text('Initial project structure is ready.'), findsOneWidget);
    expect(
      find.text(
        'Configure SUPABASE_URL and SUPABASE_ANON_KEY to enable backend tracking.',
      ),
      findsOneWidget,
    );
  });
}
