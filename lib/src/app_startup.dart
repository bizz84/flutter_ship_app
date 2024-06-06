import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/error_prompt.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/data/gist_client.dart';
import 'package:flutter_ship_app/src/utils/app_theme_data.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';
import 'package:flutter_ship_app/src/utils/package_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup.g.dart';

/// App startup provider and widget (below)
/// For more info, read: https://codewithandrea.com/articles/robust-app-initialization-riverpod/
@riverpod
class AppStartupNotifier extends _$AppStartupNotifier {
  @override
  Future<void> build() async {
    // Initially, load the database from JSON
    await _updateDatabaseFromJsonTemplate();
    // Preload any other FutureProviders what will be used with requireValue later
    await ref.watch(packageInfoProvider.future);
  }

  Future<void> _updateDatabaseFromJsonTemplate() async {
    final db = ref.watch(appDatabaseProvider);
    if (await db.isEpicsTableEmpty()) {
      // * First time load: sync with JSON data from the local root bundle
      final jsonString = await rootBundle
          .loadString('assets/common/app_release_template.json');
      final jsonData = jsonDecode(jsonString);
      await db.loadOrUpdateFromTemplate(jsonData);
    } else {
      // * Subsequent loads: sync with JSON data from the network
      final jsonString = await ref.watch(fetchJsonTemplateProvider.future);
      final jsonData = jsonDecode(jsonString);
      await db.loadOrUpdateFromTemplate(jsonData);
    }
  }

  Future<void> retry() async {
    state = await AsyncValue.guard(_updateDatabaseFromJsonTemplate);
  }
}

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. eagerly initialize appStartupProvider (and all the providers it depends on)
    final appStartupState = ref.watch(appStartupNotifierProvider);
    return appStartupState.when(
      // 2. loading state
      loading: () => const AppStartupLoadingWidget(),
      // 3. error state
      error: (e, st) {
        const action = kIsWeb ? 'clear your web cache' : 'try again';
        final message =
            'Could not load or sync data. Please $action or contact support if the issue persists.\n\n${e.toString()}';
        return AppStartupErrorWidget(
          message: message,
          // 4. invalidate the appStartupProvider
          onRetry: () async {
            await ref.read(appStartupNotifierProvider.notifier).retry();
          },
        );
      },
      // 5. success - now load the main app
      data: (_) => onLoaded(context),
    );
  }
}

class AppStartupLoadingWidget extends ConsumerWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.light(),
      darkTheme: AppThemeData.dark(),
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(Sizes.p16),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class AppStartupErrorWidget extends ConsumerWidget {
  const AppStartupErrorWidget(
      {super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.light(),
      darkTheme: AppThemeData.dark(),
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ErrorPrompt(
              message: message,
              onRetry: onRetry,
            ),
          ),
        ),
      ),
    );
  }
}
