abstract class Calculator {
  int add(String input);
}

class NegativeNumbersException implements Exception {
  NegativeNumbersException(this.negatives);
  final List<int> negatives;
  @override
  String toString() => 'Negatives not allowed: ${negatives.join(', ')}';
}

class StringCalculator extends Calculator {
  @override
  int add(String input) {
    if (input.isEmpty) return 0;
    RegExp re = RegExp(r'-?\d+');
    int sum = 0;
    List<int> negatives = [];

    for (final m in re.allMatches(input)) {
      final n = int.parse(m.group(0)!);
      if (n < 0) {
        negatives.add(n);
      } else if (n > 1000) {
        continue;
      } else {
        sum += n;
      }
    }

    if (negatives.isNotEmpty) {
      throw NegativeNumbersException(negatives);
    }
    return sum;
  }
}
