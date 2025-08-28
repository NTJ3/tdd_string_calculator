class NegativeNumbersException implements Exception {
  NegativeNumbersException(this.negatives);
  final List<int> negatives;
  @override
  String toString() => 'Negatives not allowed: ${negatives.join(', ')}';
}

class StringCalculator {
  /// Adds numbers from a delimited string
  /// Supports: comma, newline, custom delimiters, bracket delimiters
  /// Rules: ignores numbers > 1000, throws on negatives
  int add(String input) {
    if (input.isEmpty) return 0;

    final (delimiters, numbers) = _parseDelimiters(input);
    final parts = _splitNumbers(numbers, delimiters);

    return _calculateSum(parts);
  }

  /// Parse delimiters and return (delimiters, numbersSection)
  (List<String>, String) _parseDelimiters(String input) {
    const defaultDelimiters = [',', r'\n'];

    if (!input.startsWith('//')) {
      return (defaultDelimiters, input);
    }

    final newlineIndex = input.indexOf('\n');
    if (newlineIndex == -1) {
      throw const FormatException('Invalid delimiter format: missing newline');
    }

    final delimiterSection = input.substring(2, newlineIndex);
    final numbersSection = input.substring(newlineIndex + 1);

    final customDelimiters = delimiterSection.startsWith('[')
        ? _extractBracketDelimiters(delimiterSection)
        : [delimiterSection];

    return (
      [...defaultDelimiters, ...customDelimiters.map(RegExp.escape)],
      numbersSection,
    );
  }

  /// Extract delimiters from bracket format: [*][%] or [***]
  List<String> _extractBracketDelimiters(String section) {
    final matches = RegExp(r'\[([^\]]+)\]').allMatches(section);
    final delimiters = matches
        .map((m) => m.group(1)!)
        .where((d) => d.isNotEmpty)
        .toList();

    if (delimiters.isEmpty) {
      throw const FormatException('No valid delimiters found in brackets');
    }

    return delimiters;
  }

  /// Split numbers using delimiters
  List<String> _splitNumbers(String numbers, List<String> delimiters) {
    final pattern = RegExp(delimiters.join('|'));
    return numbers
        .split(pattern)
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  /// Calculate sum with validation rules
  int _calculateSum(List<String> parts) {
    var sum = 0;
    final negatives = <int>[];

    for (final part in parts) {
      final number = int.tryParse(part);
      if (number == null) continue; // Skip invalid numbers

      if (number < 0) {
        negatives.add(number);
      } else if (number <= 1000) {
        sum += number;
      }
      // Numbers > 1000 are ignored
    }

    if (negatives.isNotEmpty) {
      throw NegativeNumbersException(negatives);
    }

    return sum;
  }
}
