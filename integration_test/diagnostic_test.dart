import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Test diagnostic minimal — vérifie que le framework fonctionne
// sur ce device sans aucune dépendance à l'app.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('rendu trivial : find.text fonctionne', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Text('hello agrimada'))),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('hello agrimada'), findsOneWidget);
  });
}
