import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/screens/registration_page.dart';

void main() {
  testWidgets('Check input fields and register button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Registration());

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