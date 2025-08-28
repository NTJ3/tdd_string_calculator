import 'package:flutter/material.dart';

import 'string_calculator.dart';
import 'ui/calculator_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final calculator = StringCalculator();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(calculator: calculator),
    );
  }
}
