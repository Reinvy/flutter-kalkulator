import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_kalkulator/app_theme.dart';
import 'package:flutter_kalkulator/view_models/theme_view_model.dart';
import 'package:flutter_kalkulator/views/history_sheet.dart';
import 'package:flutter_kalkulator/views/widgets/button_grid.dart';
import 'package:flutter_kalkulator/views/widgets/display_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeVm = context.watch<ThemeViewModel>();
    final isDark = themeVm.isDark;

    final gradientStart = isDark ? CherryBlossomColors.surfaceDark : CherryBlossomColors.surface;
    final gradientEnd = isDark ? CherryBlossomColors.secondaryDark : CherryBlossomColors.secondary;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradientStart, gradientEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── AppBar ──────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🌸 Kalkulator',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? CherryBlossomColors.primaryDarkMode
                            : CherryBlossomColors.primaryDark,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          tooltip: 'Riwayat',
                          icon: Icon(
                            Icons.history_rounded,
                            color: isDark
                                ? CherryBlossomColors.primaryDarkMode
                                : CherryBlossomColors.primaryDark,
                          ),
                          onPressed: () => _showHistory(context),
                        ),
                        IconButton(
                          tooltip: isDark ? 'Mode Terang' : 'Mode Gelap',
                          icon: Icon(
                            isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                            color: isDark
                                ? CherryBlossomColors.primaryDarkMode
                                : CherryBlossomColors.primaryDark,
                          ),
                          onPressed: () => themeVm.toggle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

              // ── Display ─────────────────────────────────────────────────
              const Spacer(),
              const DisplayWidget(),
              const SizedBox(height: 12),

              // ── Divider ─────────────────────────────────────────────────
              Divider(
                height: 1,
                indent: 24,
                endIndent: 24,
                color: (isDark
                        ? CherryBlossomColors.buttonOperatorDark
                        : CherryBlossomColors.buttonOperator)
                    .withAlpha(128),
              ),
              const SizedBox(height: 8),

              // ── Buttons ─────────────────────────────────────────────────
              const ButtonGrid(),
            ],
          ),
        ),
      ),
    );
  }

  void _showHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const HistorySheet(),
    );
  }
}
