import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kalkulator/app_theme.dart';
import 'package:flutter_kalkulator/view_models/calculator_view_model.dart';
import 'package:provider/provider.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({Key? key}) : super(key: key);

  String _formatNumber(String input) {
    if (input == 'Error' || input == '-Error') return input;
    final isNegative = input.startsWith('-');
    final raw = isNegative ? input.substring(1) : input;
    final parts = raw.split('.');
    final intPart = parts[0];
    final fracPart = parts.length > 1 ? '.${parts[1]}' : '';

    final buffer = StringBuffer();
    int count = 0;
    for (int i = intPart.length - 1; i >= 0; i--) {
      if (count != 0 && count % 3 == 0) buffer.write('.');
      buffer.write(intPart[i]);
      count++;
    }
    final formatted = buffer.toString().split('').reversed.join('');
    return '${isNegative ? '-' : ''}$formatted$fracPart';
  }

  @override
  Widget build(BuildContext context) {
    final calculator = context.watch<CalculatorViewModel>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final expressionColor =
        isDark ? CherryBlossomColors.displayExpressionDark : CherryBlossomColors.displayExpression;
    final resultColor =
        isDark ? CherryBlossomColors.primaryDarkMode : CherryBlossomColors.primaryDark;

    final expressionText =
        calculator.expressionDisplay.isNotEmpty ? calculator.expressionDisplay : '';
    final resultText = _formatNumber(
      calculator.result != null ? _cleanDouble(calculator.result!) : calculator.tempDisplay,
    );

    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: resultText));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: isDark
                ? CherryBlossomColors.buttonOperatorDark
                : CherryBlossomColors.buttonOperator,
            content: Text(
              'Disalin ke clipboard',
              style: TextStyle(
                color: isDark ? CherryBlossomColors.onSurfaceDark : CherryBlossomColors.onSurface,
              ),
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(28, 16, 28, 8),
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(anim),
                  child: child,
                ),
              ),
              child: Text(
                expressionText,
                key: ValueKey(expressionText),
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: expressionColor,
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(anim),
                  child: child,
                ),
              ),
              child: Text(
                resultText,
                key: ValueKey(resultText),
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w700,
                  color: resultColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _cleanDouble(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }
}
