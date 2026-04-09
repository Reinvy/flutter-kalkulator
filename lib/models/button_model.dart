class ButtonModel {
  String symbol;
  String operator;

  ButtonModel({
    required this.symbol,
    required this.operator,
  });
}

List<ButtonModel> buttons = [
  ButtonModel(symbol: "C", operator: 'clear'),
  ButtonModel(symbol: "±", operator: 'plus-min'),
  ButtonModel(symbol: "%", operator: 'percent'),
  ButtonModel(symbol: "÷", operator: 'division'),
  ButtonModel(symbol: "7", operator: 'number'),
  ButtonModel(symbol: "8", operator: 'number'),
  ButtonModel(symbol: "9", operator: 'number'),
  ButtonModel(symbol: "\u00d7", operator: 'multiplication'),
  ButtonModel(symbol: "4", operator: 'number'),
  ButtonModel(symbol: "5", operator: 'number'),
  ButtonModel(symbol: "6", operator: 'number'),
  ButtonModel(symbol: "-", operator: 'subtraction'),
  ButtonModel(symbol: "1", operator: 'number'),
  ButtonModel(symbol: "2", operator: 'number'),
  ButtonModel(symbol: "3", operator: 'number'),
  ButtonModel(symbol: "+", operator: 'summation'),
  ButtonModel(symbol: ".", operator: 'comma'),
  ButtonModel(symbol: "0", operator: 'number'),
  ButtonModel(symbol: "\u232B", operator: 'remove'),
  ButtonModel(symbol: "=", operator: 'results'),
];
