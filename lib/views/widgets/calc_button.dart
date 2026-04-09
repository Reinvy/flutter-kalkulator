import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kalkulator/app_theme.dart';
import 'package:flutter_kalkulator/models/button_model.dart';

enum _ButtonType { number, operator, special, equals }

class CalcButton extends StatefulWidget {
  final ButtonModel button;
  final VoidCallback onTap;

  const CalcButton({Key? key, required this.button, required this.onTap}) : super(key: key);

  @override
  State<CalcButton> createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> with SingleTickerProviderStateMixin {
  bool _pressed = false;

  _ButtonType get _type {
    switch (widget.button.operator) {
      case 'number':
      case 'comma':
        return _ButtonType.number;
      case 'results':
        return _ButtonType.equals;
      case 'clear':
      case 'plus-min':
      case 'percent':
      case 'remove':
        return _ButtonType.special;
      default:
        return _ButtonType.operator;
    }
  }

  Color _bgColor(bool isDark) {
    switch (_type) {
      case _ButtonType.number:
        return isDark ? CherryBlossomColors.buttonNumberDark : CherryBlossomColors.buttonNumber;
      case _ButtonType.operator:
        return isDark ? CherryBlossomColors.buttonOperatorDark : CherryBlossomColors.buttonOperator;
      case _ButtonType.special:
        return isDark ? CherryBlossomColors.buttonSpecialDark : CherryBlossomColors.buttonSpecial;
      case _ButtonType.equals:
        return Colors.transparent; // gradient handled separately
    }
  }

  Color _fgColor(bool isDark) {
    switch (_type) {
      case _ButtonType.number:
        return isDark ? CherryBlossomColors.onSurfaceDark : CherryBlossomColors.onSurface;
      case _ButtonType.operator:
        return isDark ? CherryBlossomColors.primaryDarkMode : CherryBlossomColors.primaryDark;
      case _ButtonType.special:
        return isDark ? CherryBlossomColors.onSurfaceDark : CherryBlossomColors.onSurface;
      case _ButtonType.equals:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = _fgColor(isDark);
    final bg = _bgColor(isDark);

    Widget content = Center(
      child: Text(
        widget.button.symbol,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );

    Widget buttonBody = AnimatedScale(
      scale: _pressed ? 0.88 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: _type == _ButtonType.equals
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    CherryBlossomColors.accentGold,
                    CherryBlossomColors.primary,
                    CherryBlossomColors.primaryDark,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: CherryBlossomColors.primary.withAlpha(120),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: bg,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 60 : 25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
        child: content,
      ),
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: Semantics(
        button: true,
        label: _semanticsLabel(widget.button),
        child: buttonBody,
      ),
    );
  }

  String _semanticsLabel(ButtonModel b) {
    const labels = {
      'clear': 'Clear all',
      'plus-min': 'Toggle sign',
      'percent': 'Percentage',
      'remove': 'Backspace',
      'division': 'Divide',
      'multiplication': 'Multiply',
      'summation': 'Add',
      'subtraction': 'Subtract',
      'results': 'Equals',
      'comma': 'Decimal point',
    };
    return labels[b.operator] ?? b.symbol;
  }
}
