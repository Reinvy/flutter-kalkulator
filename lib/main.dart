import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_kalkulator/app_theme.dart';
import 'package:flutter_kalkulator/view_models/calculator_view_model.dart';
import 'package:flutter_kalkulator/view_models/theme_view_model.dart';
import 'package:flutter_kalkulator/views/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeVm, _) => MaterialApp(
          title: 'Cherry Blossom Calc',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeVm.themeMode,
          home: const MainScreen(),
        ),
      ),
    );
  }
}
