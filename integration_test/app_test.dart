import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Full App Testing', () {
    testWidgets("Register and Navigate to Login", (WidgetTester tester) async {
      //Add register logic here
    });

    testWidgets("Login and Navigate to Home", (WidgetTester tester) async {
      //Add login logic here
    });

    testWidgets('Test if the app opens', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Test if you can navigate to profile', (WidgetTester tester) async {

    });

  });
}
