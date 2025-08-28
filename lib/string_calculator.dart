class NegativeNumbersException implements Exception {
  NegativeNumbersException(this.negatives);
  final List<int> negatives;
  @override
  String toString() => 'Negatives not allowed: ${negatives.join(', ')}';
}

class StringCalculator {
  int add(String input) {
    if (input.isEmpty) return 0;
    final parts = input.split(',');
    return parts.map((s) => int.parse(s)).reduce((a, b) => a + b);
  }
}
