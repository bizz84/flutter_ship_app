import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/app_routes.dart';
import 'package:flutter_ship_app/src/app_startup.dart';
import 'package:flutter_ship_app/src/domain/app.dart';
import 'package:flutter_ship_app/src/domain/epic.dart';
import 'package:flutter_ship_app/src/presentation/create_edit_app_screen.dart';
import 'package:flutter_ship_app/src/presentation/epics_checklist_screen.dart';
import 'package:flutter_ship_app/src/presentation/settings_screen.dart';
import 'package:flutter_ship_app/src/presentation/tasks_checklist_screen.dart';
import 'package:flutter_ship_app/src/utils/shared_preferences_provider.dart';
import 'package:flutter_ship_app/src/presentation/apps_list_screen.dart';
import 'package:flutter_ship_app/src/utils/app_theme_data.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';

Future<void> runMainApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  // * Preload SharedPreferences before calling runApp, as the AppStartupWidget
  // * depends on it in order to load the themeMode
  await container.read(sharedPreferencesProvider.future);
  // run the app
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
      theme: AppThemeData.light(),
      darkTheme: AppThemeData.dark(),
      themeMode: themeMode,
      onGenerateRoute: (settings) {
        // * This app uses named routes. For more info, read:
        // * https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments
        return switch (settings.name) {
          AppRoutes.apps => MaterialPageRoute(
              settings: settings,
              builder: (_) => const AppsListScreen(),
            ),
          AppRoutes.createApp => MaterialPageRoute(
              settings: settings,
              fullscreenDialog: true,
              builder: (_) {
                return const CreateOrEditAppScreen();
              },
            ),
          AppRoutes.editApp => MaterialPageRoute(
              settings: settings,
              fullscreenDialog: true,
              builder: (_) {
                final app = settings.arguments as App;
                return CreateOrEditAppScreen(app: app);
              },
            ),
          AppRoutes.epics => MaterialPageRoute(
              settings: settings,
              builder: (_) {
                final app = settings.arguments as App;
                return EpicsChecklistScreen(app: app);
              },
            ),
          AppRoutes.tasks => MaterialPageRoute(
              settings: settings,
              builder: (_) {
                final args = settings.arguments as ({App app, Epic epic});
                return TasksChecklistScreen(app: args.app, epic: args.epic);
              },
            ),
          AppRoutes.settings => MaterialPageRoute(
              settings: settings,
              fullscreenDialog: true,
              builder: (_) => const SettingsScreen(),
            ),
          _ =>
            throw UnimplementedError('Route named ${settings.name} not found'),
        };
      },
      initialRoute: AppRoutes.apps,
    );
  }
}

// ignore_for_file:avoid-undisposed-instances,avoid-nullable-interpolation