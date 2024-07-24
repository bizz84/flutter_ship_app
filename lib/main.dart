//import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/env/env.dart';
import 'package:flutter_ship_app/env/flavor.dart';
import 'package:flutter_ship_app/src/app_startup.dart';
import 'package:flutter_ship_app/src/utils/shared_preferences_provider.dart';
import 'package:flutter_ship_app/src/presentation/apps_list_screen.dart';
import 'package:flutter_ship_app/src/utils/app_theme_data.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';
import 'package:flutter_ship_app/src/utils/canvas_kit/is_canvas_kit.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  // * Preload SharedPreferences before calling runApp, as the AppStartupWidget
  // * depends on it in order to load the themeMode
  await container.read(sharedPreferencesProvider.future);
  // * Initialize Sentry
  await SentryFlutter.init(
    (options) {
      options.dsn = Env.sentryDsn;
      options.environment = getFlavor().name;
      // Use the beforeSend callback to filter which events are sent
      options.beforeSend = (SentryEvent event, Hint hint) async {
        // Filter out all events if we're not in release mode
        if (!kReleaseMode) return null;
        return event;
      };
    },
  );
  runApp(UncontrolledProviderScope(
    container: container,
    child: AppStartupWidget(
      onLoaded: (context) =>
          // * Don't wrap with BetterFeedback if web HTML renderer is used
          // https://pub.dev/packages/feedback#-known-issues-and-limitations
          !kIsWeb || isCanvasKitRenderer()
              ? const BetterFeedback(child: MainApp())
              : const MainApp(),
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
      home: const AppsListScreen(),
      // * Uncomment this line to perform accessibility checks
      // builder: (context, child) => AccessibilityTools(child: child),
    );
  }
}
