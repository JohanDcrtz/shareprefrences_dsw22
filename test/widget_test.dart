import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shareprefrences_dsw22/main.dart';

void main() {
  testWidgets('Refresh button updates inventory view', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the initial state shows inventory content.
    expect(find.text('Inventory Content'), findsOneWidget);

    // Tap the refresh button and trigger a frame.
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    // Verify that the inventory view has been updated.
    expect(find.text('Updated Inventory Content'), findsOneWidget);
  });
}
