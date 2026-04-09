import 'package:flutter/material.dart';
import 'package:flutter_kalkulator/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorViewModel with ChangeNotifier {
  static const _historyKey = 'calc_history';
  static const _maxHistory = 20;

  String tempDisplay = '0';
  String expressionDisplay = '';
  double? result;
  double? a;
  String? currentOperation;

  final List<HistoryEntry> _history = [];
  List<HistoryEntry> get history => List.unmodifiable(_history);

  CalculatorViewModel() {
    _loadHistory();
  }

  // ─── Display Helpers ───────────────────────────────────────────────────────

  String _cleanDouble(double value) {
    if (value == value.truncateToDouble()) return value.toInt().toString();
    return value.toString();
  }

  // ─── Input ─────────────────────────────────────────────────────────────────

  void changeDisplay(String number) {
    if (result != null) {
      // Start fresh after a completed calculation
      tempDisplay = number;
      result = null;
      expressionDisplay = '';
    } else if (tempDisplay == '0') {
      tempDisplay = number;
    } else {
      tempDisplay += number;
    }
    notifyListeners();
  }

  void addDecimal() {
    if (result != null) {
      tempDisplay = '0.';
      result = null;
      expressionDisplay = '';
    } else if (!tempDisplay.contains('.')) {
      tempDisplay += '.';
    }
    notifyListeners();
  }

  // ─── Actions ───────────────────────────────────────────────────────────────

  void clear() {
    tempDisplay = '0';
    expressionDisplay = '';
    a = null;
    result = null;
    currentOperation = null;
    notifyListeners();
  }

  void remove() {
    if (tempDisplay.length > 1) {
      tempDisplay = tempDisplay.substring(0, tempDisplay.length - 1);
    } else {
      tempDisplay = '0';
    }
    notifyListeners();
  }

  void plusMinus() {
    if (tempDisplay == '0') return;
    if (tempDisplay.startsWith('-')) {
      tempDisplay = tempDisplay.substring(1);
    } else {
      tempDisplay = '-$tempDisplay';
    }
    notifyListeners();
  }

  void percentage() {
    final value = double.tryParse(tempDisplay) ?? 0;
    tempDisplay = _cleanDouble(value / 100);
    notifyListeners();
  }

  // ─── Operations ────────────────────────────────────────────────────────────

  void _calculate() {
    if (a == null || currentOperation == null) return;
    final b = double.tryParse(tempDisplay);
    if (b == null) return;

    double? res;
    switch (currentOperation) {
      case '+':
        res = a! + b;
        break;
      case '-':
        res = a! - b;
        break;
      case '*':
        res = a! * b;
        break;
      case '/':
        if (b == 0) {
          tempDisplay = 'Error';
          expressionDisplay = '';
          a = null;
          currentOperation = null;
          result = null;
          notifyListeners();
          return;
        }
        res = a! / b;
        break;
    }
    if (res != null) {
      result = res;
      tempDisplay = _cleanDouble(res);
    }
  }

  void setOperation(String operation) {
    final opSymbol = _opSymbol(operation);
    if (a == null) {
      a = double.tryParse(tempDisplay);
      expressionDisplay = '$tempDisplay $opSymbol';
    } else {
      _calculate();
      if (tempDisplay == 'Error') return;
      a = result ?? double.tryParse(tempDisplay);
      result = null;
      expressionDisplay = '${_cleanDouble(a!)} $opSymbol';
    }
    currentOperation = operation;
    tempDisplay = '0';
    notifyListeners();
  }

  void performEquals() {
    if (a == null || currentOperation == null) return;
    final bStr = tempDisplay;
    final expression = '${_cleanDouble(a!)} ${_opSymbol(currentOperation!)} $bStr';
    _calculate();
    if (tempDisplay != 'Error') {
      _addToHistory(expression, tempDisplay);
    }
    expressionDisplay = '$expression =';
    a = null;
    currentOperation = null;
    notifyListeners();
  }

  String _opSymbol(String op) {
    switch (op) {
      case '*':
        return '×';
      case '/':
        return '÷';
      case '+':
        return '+';
      case '-':
        return '−';
      default:
        return op;
    }
  }

  // ─── Decision Maker ────────────────────────────────────────────────────────

  void decisionMaking(String operator, String symbol) {
    switch (operator) {
      case 'number':
        changeDisplay(symbol);
        break;
      case 'comma':
        addDecimal();
        break;
      case 'clear':
        clear();
        break;
      case 'remove':
        remove();
        break;
      case 'plus-min':
        plusMinus();
        break;
      case 'percent':
        percentage();
        break;
      case 'multiplication':
        setOperation('*');
        break;
      case 'division':
        setOperation('/');
        break;
      case 'summation':
        setOperation('+');
        break;
      case 'subtraction':
        setOperation('-');
        break;
      case 'results':
        performEquals();
        break;
    }
  }

  // ─── History ───────────────────────────────────────────────────────────────

  void _addToHistory(String expression, String result) {
    _history.insert(
      0,
      HistoryEntry(
        expression: expression,
        result: result,
        timestamp: DateTime.now(),
      ),
    );
    if (_history.length > _maxHistory) _history.removeLast();
    _saveHistory();
  }

  void clearHistory() {
    _history.clear();
    _saveHistory();
    notifyListeners();
  }

  void applyHistoryResult(String value) {
    tempDisplay = value;
    result = null;
    expressionDisplay = '';
    notifyListeners();
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _history.map((e) => e.toStorageString()).toList();
    await prefs.setStringList(_historyKey, encoded);
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_historyKey) ?? [];
    _history
      ..clear()
      ..addAll(stored.map(HistoryEntry.fromStorageString));
    notifyListeners();
  }
}
