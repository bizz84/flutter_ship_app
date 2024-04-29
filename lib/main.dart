import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/constants/app_colors.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/data/app_startup.dart';
import 'package:flutter_ship_app/src/data/shared_preferences.dart';
import 'package:flutter_ship_app/src/presentation/apps_list_screen.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  // needed to read the theme mode before calling runApp
  await container.read(sharedPreferencesProvider.future);
  // run app
  runApp(UncontrolledProviderScope(
    container: container,
    child: AppStartupWidget(
      onLoaded: (context) => const MainApp(),
    ),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // https://docs.flexcolorscheme.com/
      theme: FlexThemeData.light(scheme: AppColors.flexScheme).customAppTheme(),
      darkTheme:
          FlexThemeData.dark(scheme: AppColors.flexScheme).customAppTheme(),
      themeMode: themeMode,
      home: const AppsListScreen(),
      // * Uncomment this line to perform accessibility checks
      // builder: (context, child) => AccessibilityTools(child: child),
    );
  }
}

extension AppThemeData on ThemeData {
  ThemeData customAppTheme() {
    // An updated theme with bigger text sizes
    return copyWith(
      textTheme: TextTheme(
        titleLarge: textTheme.titleLarge?.copyWith(fontSize: 22.0),
        titleMedium: textTheme.titleMedium?.copyWith(fontSize: 18.0),
        titleSmall: textTheme.titleMedium?.copyWith(fontSize: 14.0),
        bodyLarge: textTheme.bodyLarge?.copyWith(fontSize: 20.0),
        bodyMedium: textTheme.bodyMedium?.copyWith(fontSize: 18.0),
        bodySmall: textTheme.bodySmall?.copyWith(fontSize: 14.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(Sizes.p8),
          textStyle:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
