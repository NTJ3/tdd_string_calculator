import 'package:flutter/material.dart';

import '../string_calculator.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key, required this.calculator});
  final Calculator calculator;

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _controller = TextEditingController();
  String? _result;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onAdd() {
    setState(() {
      _result = null;
      _error = null;
      try {
        final value = widget.calculator.add(_controller.text);
        _result = 'Result: $value';
      } on NegativeNumbersException catch (e) {
        _error = e.toString();
      } on FormatException catch (e) {
        _error = e.message;
      } catch (e) {
        _error = 'Error: $e';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('String Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              key: const Key('inputField'),
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter numbers (e.g. 1,2 or //[***]\\n1***2***3)',
                border: OutlineInputBorder(),
              ),
              minLines: 1,
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              key: const Key('addButton'),
              onPressed: _onAdd,
              child: const Text('Add'),
            ),
            const SizedBox(height: 12),
            if (_result != null) Text(_result!, key: const Key('resultText')),
            if (_error != null)
              Text(
                _error!,
                key: const Key('errorText'),
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
