import 'package:dio/dio.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/app_routes.dart';
import 'package:flutter_ship_app/env/env.dart';
import 'package:flutter_ship_app/env/flavor.dart';
import 'package:flutter_ship_app/src/app_startup.dart';
import 'package:flutter_ship_app/src/domain/app.dart';
import 'package:flutter_ship_app/src/domain/epic.dart';
import 'package:flutter_ship_app/src/monitoring/analytics_facade.dart';
import 'package:flutter_ship_app/src/monitoring/logger_navigator_observer.dart';
import 'package:flutter_ship_app/src/monitoring/mixpanel_analytics_client.dart';
import 'package:flutter_ship_app/src/presentation/create_edit_app_screen.dart';
import 'package:flutter_ship_app/src/presentation/epics_checklist_screen.dart';
import 'package:flutter_ship_app/src/presentation/settings_screen.dart';
import 'package:flutter_ship_app/src/presentation/tasks_checklist_screen.dart';
import 'package:flutter_ship_app/src/utils/shared_preferences_provider.dart';
import 'package:flutter_ship_app/src/presentation/apps_list_screen.dart';
import 'package:flutter_ship_app/src/utils/app_theme_data.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';
import 'package:flutter_ship_app/src/utils/canvas_kit/is_canvas_kit.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SentryFlutter.init(
    (options) {
      options.dsn = Env.sentryDsn;
      options.environment = getFlavor().name;
      // Improve stack traces in the dashboard
      options
        ..considerInAppFramesByDefault = false
        ..addInAppInclude('flutter_ship_app');
      // Use the beforeSend callback to filter which events are sent
      options.beforeSend = (SentryEvent event, Hint hint) async {
        // Ignore events that are not from release builds
        if (!kReleaseMode) {
          return null;
        }
        // If there was no response, it means that a connection error occurred
        // Do not log this to Sentry
        final exception = event.throwable;
        if (exception is DioException && exception.response == null) {
          return null;
        }
        // For all other events, return the event as is
        return event;
      };
    },
  );
  final container = ProviderContainer();
  // * Preload SharedPreferences before calling runApp, as the AppStartupWidget
  // * depends on it in order to load the themeMode
  await container.read(sharedPreferencesProvider.future);
  // * Preload MixpanelAnalyticsClient, so we can make unawaited analytics calls
  await container.read(mixpanelAnalyticsClientProvider.future);
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
      navigatorObservers: [
        SentryNavigatorObserver(),
        LoggerNavigatorObserver(ref.read(analyticsFacadeProvider)),
      ],
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