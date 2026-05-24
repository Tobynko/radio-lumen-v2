import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_card.dart';

void main() {
  group('LumenCard Widget Tests', () {
    testWidgets('LumenCard renders child correctly', (WidgetTester tester) async {
      const childText = 'Test Child';
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LumenCard(
              child: Text(childText),
            ),
          ),
        ),
      );

      expect(find.text(childText), findsOneWidget);
    });

    testWidgets('LumenCard handles onTap', (WidgetTester tester) async {
      bool tapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LumenCard(
              onTap: () => tapped = true,
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue);
    });

    testWidgets('LumenCard applies padding and margin', (WidgetTester tester) async {
      const padding = EdgeInsets.all(16.0);
      const margin = EdgeInsets.all(8.0);
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LumenCard(
              padding: padding,
              margin: margin,
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      final container = tester.widget<Container>(containerFinder);
      
      expect(container.padding, padding);
      
      // Margin is implemented as a Padding widget around the Container
      final paddingWidgetFinder = find.ancestor(
        of: containerFinder,
        matching: find.byType(Padding),
      );
      final paddingWidget = tester.widget<Padding>(paddingWidgetFinder);
      expect(paddingWidget.padding, margin);
    });
  });
}
