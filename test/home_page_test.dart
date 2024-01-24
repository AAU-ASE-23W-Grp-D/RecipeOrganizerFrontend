import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/screens/home_screen.dart';
import 'package:recipe_organizer_frontend/widgets/footer.dart';
import 'package:recipe_organizer_frontend/widgets/gridview.dart';

void main() {
  group('ResponsiveNavBarPage Tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveNavBarPage(),
        ),
      );

      // Verify that the appBar title is rendered
      expect(find.text('Recipe Organizer'), findsOneWidget);

      // Verify that the contents of the screen are rendered
      expect(find.text('Recent:'), findsOneWidget);
      expect(find.byType(AppBar), findsOne);
      expect(find.byType(CircleAvatar), findsAny);
      expect(find.byType(Footer), findsOne);
      expect(find.byType(GridB), findsAny);
      expect(find.byIcon(Icons.menu), findsOne);
    });

    testWidgets('Navbar items are rendered and onTap works',
        (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return navBarItems(context);
              },
            ),
          ),
        ),
      );

      // Find the Row widget with key "navbaritems"
      expect(find.byKey(const Key("navbaritems")), findsOneWidget);

      // Verify that the expected number of items are present
      expect(find.byType(InkWell), findsNWidgets(menuItems.length));

      // Verify that tapping each item triggers the expected action
      await tester.tap(find.text(menuItems[0]));
      await tester.pump();
    });

    testWidgets('ProfileIcon shows PopupMenu', (WidgetTester tester) async {
      // Build our widget and trigger a frame
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ProfileIcon(),
        ),
      ));

      // Verify that the initial state has the icon
      expect(find.byIcon(Icons.person), findsOneWidget);

      // Tap the icon to open the PopupMenu
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Verify that the PopupMenu is shown
      expect(find.byType(PopupMenuButton<Menu>), findsOneWidget);

      // Verify that the PopupMenuItems are present
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Liked Recipes'), findsOneWidget);
      expect(find.text('Sign Out'), findsOneWidget);
    });

    // Add more tests as needed
  });
}
