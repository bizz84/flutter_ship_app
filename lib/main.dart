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
    final light = FlexThemeData.light(scheme: AppColors.flexScheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // https://docs.flexcolorscheme.com/
      theme: light.copyWith(
        textTheme: TextTheme(
          titleLarge: light.textTheme.titleLarge?.copyWith(fontSize: 22.0),
          titleMedium: light.textTheme.titleMedium?.copyWith(fontSize: 18.0),
          titleSmall: light.textTheme.titleMedium?.copyWith(fontSize: 14.0),
          bodyLarge: light.textTheme.bodyLarge?.copyWith(fontSize: 20.0),
          bodyMedium: light.textTheme.bodyMedium?.copyWith(fontSize: 18.0),
          bodySmall: light.textTheme.bodySmall?.copyWith(fontSize: 14.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(Sizes.p8),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      darkTheme: FlexThemeData.dark(scheme: AppColors.flexScheme),
      themeMode: ThemeMode.system,
      home: const AppsListScreen(),
    );
  }
}
