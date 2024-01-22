import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';
void main() {
  //setUpAll(() => HttpOverrides.global = null);
  testWidgets('RecipeDetailScreenWeb should render', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    mockNetworkImagesFor(() => tester.pumpWidget(
      MaterialApp(
        //home: RecipeDetailScreenWeb(recipe: null,),
      ),
    ));

    // Wait for the network images to load
    
      // Verify if the widget renders correctly.
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Ingredients'), findsOneWidget);
      expect(find.byType(ImageColumn), findsOneWidget);
      expect(find.byType(IngridientColumn), findsOneWidget);
      expect(find.byType(DescriptionColumn), findsOneWidget);
      expect(find.byKey(const Key('imageColumn')), findsOneWidget);
      expect(find.byKey(const Key('ingridientList')), findsOneWidget);
    
  });

  testWidgets(
    'should properly mock Image.network and not crash',
    (WidgetTester tester) async {
      mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
        //home: RecipeDetailScreenWeb(recipe: null,),
      ),
      ));
    },
  );
}
