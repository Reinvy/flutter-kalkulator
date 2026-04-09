import 'package:flutter/material.dart';

class CalculatorViewModel with ChangeNotifier {
  List<num> numbers = [0];
  List<String> operations = [];
  double? result;
  String tempDisplay = "0";
  double? a; // Stores the first operand
  double? b; // Stores the second operand
  String? currentOperation; // Stores the current operation

  changeDisplay(String number) {
    if (tempDisplay == "0") {
      tempDisplay = number;
    } else {
      tempDisplay += number;
    }
    notifyListeners();
  }

  clear() {
    tempDisplay = "0";
    a = null;
    b = null;
    result = null;
    currentOperation = null;
    notifyListeners();
  }

  remove() {
    if (tempDisplay.length > 1) {
      tempDisplay = tempDisplay.substring(0, tempDisplay.length - 1);
    } else {
      tempDisplay = "0";
    }
    notifyListeners();
  }

  plusMinus() {
    if (tempDisplay.startsWith("-")) {
      tempDisplay = tempDisplay.substring(1);
    } else {
      tempDisplay = "-" + tempDisplay;
    }
    notifyListeners();
  }

  percentage() {
    double value = double.tryParse(tempDisplay) ?? 0;
    tempDisplay = (value / 100).toString();
    notifyListeners();
  }

  performOperation() {
    if (a != null && currentOperation != null) {
      b = double.tryParse(tempDisplay);
      if (currentOperation == "*") {
        result = a! * b!;
      } else if (currentOperation == "/") {
        result = a! / b!;
      } else if (currentOperation == "+") {
        result = a! + b!;
      } else if (currentOperation == "-") {
        result = a! - b!;
      }
      tempDisplay = result.toString();
      a = result;
      b = null;
      currentOperation = null;
    }
  }

  setOperation(String operation) {
    if (a == null) {
      a = double.tryParse(tempDisplay);
    } else {
      performOperation();
    }
    currentOperation = operation;
    tempDisplay = "0"; // Prepare display for the next number
    notifyListeners();
  }

  decisionMaking(String operator, String symbol) {
    if (operator == "number") {
      changeDisplay(symbol);
    } else if (operator == "clear") {
      clear();
    } else if (operator == "remove") {
      remove();
    } else if (operator == "plus-min") {
      plusMinus();
    } else if (operator == "percent") {
      percentage();
    } else if (operator == "multiplication") {
      setOperation("*");
    } else if (operator == "division") {
      setOperation("/");
    } else if (operator == "summation") {
      setOperation("+");
    } else if (operator == "subtraction") {
      setOperation("-");
    } else if (operator == "results") {
      performOperation();
      notifyListeners();
    }
  }
}
