import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/constants/app_colors.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/data/app_startup.dart';
import 'package:flutter_ship_app/src/data/shared_preferences.dart';
import 'package:flutter_ship_app/src/presentation/apps_list_screen.dart';

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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // https://docs.flexcolorscheme.com/
    final theme = FlexThemeData.light(scheme: AppColors.flexScheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        textTheme: TextTheme(
          titleLarge: theme.textTheme.titleLarge?.copyWith(fontSize: 22.0),
          titleMedium: theme.textTheme.titleMedium?.copyWith(fontSize: 18.0),
          titleSmall: theme.textTheme.titleMedium?.copyWith(fontSize: 14.0),
          bodyLarge: theme.textTheme.bodyLarge?.copyWith(fontSize: 20.0),
          bodyMedium: theme.textTheme.bodyMedium?.copyWith(fontSize: 18.0),
          bodySmall: theme.textTheme.bodySmall?.copyWith(fontSize: 14.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(Sizes.p8),
            textStyle:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      darkTheme: FlexThemeData.dark(scheme: AppColors.flexScheme),
      themeMode: ThemeMode.system,
      home: const AppsListScreen(),
    );
  }
}
