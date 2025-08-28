import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {
  group('StringCalculator.add', () {
    test('empty string returns 0', () {
      expect(StringCalculator().add(''), 0);
    });

    test('single number returns itself', () {
      expect(StringCalculator().add('1'), 1);
    });

    test('two comma-separated numbers sum', () {
      expect(StringCalculator().add('1,2'), 3);
    });

    test('newlines also delimit', () {
      expect(StringCalculator().add('1\n2,3'), 6);
    });
  });
}
