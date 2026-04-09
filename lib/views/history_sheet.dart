import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_kalkulator/app_theme.dart';
import 'package:flutter_kalkulator/models/history_model.dart';
import 'package:flutter_kalkulator/view_models/calculator_view_model.dart';
import 'package:provider/provider.dart';

class HistorySheet extends StatelessWidget {
  const HistorySheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final calculator = context.watch<CalculatorViewModel>();
    final history = calculator.history;

    final sheetBg = isDark ? CherryBlossomColors.surfaceDark : CherryBlossomColors.surface;
    final headerColor =
        isDark ? CherryBlossomColors.primaryDarkMode : CherryBlossomColors.primaryDark;
    final dividerColor =
        isDark ? CherryBlossomColors.buttonOperatorDark : CherryBlossomColors.buttonOperator;

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: sheetBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: CherryBlossomColors.primary.withAlpha(80),
                blurRadius: 24,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              // ── Handle ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // ── Header ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Riwayat',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: headerColor,
                      ),
                    ),
                    if (history.isNotEmpty)
                      TextButton.icon(
                        onPressed: () {
                          context.read<CalculatorViewModel>().clearHistory();
                        },
                        icon: Icon(Icons.delete_sweep_rounded, size: 18, color: headerColor),
                        label: Text(
                          'Hapus Semua',
                          style: TextStyle(color: headerColor, fontSize: 13),
                        ),
                      ),
                  ],
                ),
              ),
              Divider(color: dividerColor.withAlpha(80), height: 1),
              // ── List ──────────────────────────────────────────────────
              Expanded(
                child: history.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history_rounded,
                                size: 56, color: dividerColor.withAlpha(128)),
                            const SizedBox(height: 12),
                            Text(
                              'Belum ada riwayat',
                              style: TextStyle(
                                color: dividerColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        itemCount: history.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: dividerColor.withAlpha(40),
                        ),
                        itemBuilder: (ctx, i) => _HistoryTile(entry: history[i], isDark: isDark),
                      ),
              ),
            ],
          ),
        )
            .animate()
            .slideY(begin: 0.2, duration: 300.ms, curve: Curves.easeOut)
            .fadeIn(duration: 300.ms);
      },
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final HistoryEntry entry;
  final bool isDark;

  const _HistoryTile({required this.entry, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final expressionColor =
        isDark ? CherryBlossomColors.displayExpressionDark : CherryBlossomColors.displayExpression;
    final resultColor =
        isDark ? CherryBlossomColors.primaryDarkMode : CherryBlossomColors.primaryDark;

    return ListTile(
      onTap: () {
        context.read<CalculatorViewModel>().applyHistoryResult(entry.result);
        Navigator.pop(context);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      title: Text(
        entry.expression,
        style: TextStyle(fontSize: 14, color: expressionColor),
        textAlign: TextAlign.end,
      ),
      subtitle: Text(
        entry.result,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: resultColor,
        ),
        textAlign: TextAlign.end,
      ),
      trailing: Text(
        _formatTime(entry.timestamp),
        style: TextStyle(fontSize: 11, color: expressionColor.withAlpha(160)),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
