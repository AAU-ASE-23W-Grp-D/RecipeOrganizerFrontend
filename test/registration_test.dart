import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/app.dart';

void main() {
  testWidgets('Check input fields and submit button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app has a username field.
    expect(find.byKey(const Key('usernameFieldRegistration')), findsOneWidget);

    // Verify that our app has a username field.
    expect(find.byKey(const Key('emailFieldRegistration')), findsOneWidget);

    // Verify that our app has a password field.
    expect(find.byKey(const Key('passwordFieldRegistration')), findsOneWidget);

    // Verify that our app has a submit button.
    expect(find.byKey(const Key('registerButton')), findsOneWidget);
  });
}