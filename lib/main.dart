import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/constants/app_colors.dart';
import 'package:flutter_ship_app/src/presentation/release_checklist_screen.dart';

void main() {
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // https://docs.flexcolorscheme.com/
      theme: FlexThemeData.light(scheme: AppColors.flexScheme),
      darkTheme: FlexThemeData.dark(scheme: AppColors.flexScheme),
      themeMode: ThemeMode.light,
      home: const ReleaseChecklistScreen(),
    );
  }
}
