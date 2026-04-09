import 'package:flutter/material.dart';
import 'package:flutter_kalkulator/models/button_model.dart';
import 'package:flutter_kalkulator/view_models/calculator_view_model.dart';
import 'package:flutter_kalkulator/views/widgets/calc_button.dart';
import 'package:provider/provider.dart';

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculator = context.read<CalculatorViewModel>();
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (ctx, i) => CalcButton(
        button: buttons[i],
        onTap: () => calculator.decisionMaking(buttons[i].operator, buttons[i].symbol),
      ),
    );
  }
}
