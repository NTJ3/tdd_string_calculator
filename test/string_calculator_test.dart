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

    test('custom single-char delimiter with //d\\n', () {
      expect(StringCalculator().add('//;\n1;2'), 3);
    });

    test('negatives throw with all negatives listed with exception', () {
      expect(
        () => StringCalculator().add('1,-2,3,-4'),
        throwsA(
          isA<NegativeNumbersException>().having(
            (e) => e.negatives,
            'negatives',
            [-2, -4],
          ),
        ),
      );
    });

    test('ignores numbers > 1000', () {
      expect(StringCalculator().add('2,1001'), 2);
      expect(StringCalculator().add('2,1000'), 1002);
    });

    test('any-length delimiter in [brackets]', () {
      expect(StringCalculator().add('//[***]\n1***2***3'), 6);
    });

    test('multiple delimiters', () {
      expect(StringCalculator().add('//[*][%]\n1*2%3'), 6);
    });

    test('multiple long delimiters', () {
      expect(StringCalculator().add('//[**][%%]\n1**2%%3'), 6);
    });

    // test('negatives throw with all negatives listed - exception', () {
    //   expect(StringCalculator().add('1,-2,3,-4'), 4);
    // });
  });
}
