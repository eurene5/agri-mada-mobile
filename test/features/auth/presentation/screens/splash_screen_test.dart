import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agri_mada/features/auth/presentation/screens/splash_screen.dart';
import 'package:agri_mada/app/theme/app_colors.dart';

void main() {
  testWidgets('Splash shows brand title and uses primary background', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    await tester.pumpAndSettle();

    expect(find.text('AgriMada'), findsOneWidget);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, AppColors.primary);
  });
}
