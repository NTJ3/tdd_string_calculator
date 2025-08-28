import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';
import 'package:tdd_string_calculator/ui/calculator_screen.dart';


void main() {
  Widget wrap(Widget child) => MaterialApp(home: child);

  testWidgets('sums valid input and shows result', (tester) async {
    await tester.pumpWidget(
      wrap(CalculatorScreen(calculator: StringCalculator())),
    );
    await tester.enterText(find.byKey(const Key('inputField')), '1\n2,3');
    await tester.tap(find.byKey(const Key('addButton')));
    await tester.pump();

    expect(find.text('Result: 6'), findsOneWidget);
    expect(find.byKey(const Key('errorText')), findsNothing);
  });

  testWidgets('shows error for negatives', (tester) async {
    await tester.pumpWidget(
      wrap(CalculatorScreen(calculator: StringCalculator())),
    );
    await tester.enterText(find.byKey(const Key('inputField')), '1,-2,3');
    await tester.tap(find.byKey(const Key('addButton')));
    await tester.pump();

    expect(find.byKey(const Key('errorText')), findsOneWidget);
    expect(find.textContaining('Negatives not allowed: -2'), findsOneWidget);
    expect(find.byKey(const Key('resultText')), findsNothing);
  });
}
