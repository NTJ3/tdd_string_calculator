class NegativeNumbersException implements Exception {
  NegativeNumbersException(this.negatives);
  final List<int> negatives;
  @override
  String toString() => 'Negatives not allowed: ${negatives.join(', ')}';
}

class StringCalculator {
  int add(String input) {
    if (input.isEmpty) return 0;
    final normalized = input.replaceAll('\n', ',');
    final parts = normalized.split(',').where((s) => s.isNotEmpty);

    int sum = 0;
    for (final part in parts) {
      try {
        final number = int.parse(part);
        sum += number;
      } catch (e) {
        continue;
      }
    }
    return sum;
  }
}
