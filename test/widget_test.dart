import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agri_mada/app/app.dart';

void main() {
  testWidgets('AgriMadaApp se construit sans erreur', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AgriMadaApp(),
      ),
    );

    expect(find.byType(AgriMadaApp), findsOneWidget);
  });
}
