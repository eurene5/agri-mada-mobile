import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

void main() {
  testWidgets('ProviderScope se construit sans erreur', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox.shrink(),
        ),
      ),
    );

    expect(find.byType(ProviderScope), findsOneWidget);
  });
}
