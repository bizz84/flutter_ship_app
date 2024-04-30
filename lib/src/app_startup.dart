import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/error_prompt.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/constants/strings.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/data/gist_client.dart';
import 'package:flutter_ship_app/src/utils/app_theme_data.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';
import 'package:flutter_ship_app/src/utils/package_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup.g.dart';

@riverpod
Future<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    // ensure we invalidate all the providers we depend on
    ref.invalidate(updateDatabaseFromJsonTemplateProvider);
  });
  await ref.watch(packageInfoProvider.future);
  // Initially, load the database from JSON
  await ref.watch(updateDatabaseFromJsonTemplateProvider.future);
}

/// Provider to load the initial data from JSON
@riverpod
Future<void> updateDatabaseFromJsonTemplate(
    UpdateDatabaseFromJsonTemplateRef ref) async {
  final db = ref.watch(appDatabaseProvider);
  try {
    // Load the JSON data from the netwosk
    final jsonString = await ref.watch(fetchJsonTemplateProvider.future);
    final jsonData = jsonDecode(jsonString);
    await db.loadOrUpdateFromTemplate(jsonData);
  } catch (e) {
    // TODO: Error monitoring
    // If the request has failed and the DB is empty (first app start),
    // fallback to loading the JSON from bundle
    if (await db.isEpicsTableEmpty()) {
      log('JSON fetching failed - loading from root bundle');
      final jsonString =
          await rootBundle.loadString('assets/app_release_template.json');
      final jsonData = jsonDecode(jsonString);
      await db.loadOrUpdateFromTemplate(jsonData);
    }
  }
}

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. eagerly initialize appStartupProvider (and all the providers it depends on)
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      // 3. loading state
      loading: () => const AppStartupLoadingWidget(),
      // 4. error state
      error: (e, st) => AppStartupErrorWidget(
        exception: e,
        // 5. invalidate the appStartupProvider
        onRetry: () => ref.invalidate(appStartupProvider),
      ),
      // 6. success - now load the main app
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
        appBar: AppBar(title: Text(Strings.myAppsTitle)),
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
      {super.key, required this.exception, required this.onRetry});
  final Object exception;
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
        appBar: AppBar(title: Text(Strings.myAppsTitle)),
        body: Center(
          child: ErrorPrompt(
            exception: exception,
            onRetry: onRetry,
          ),
        ),
      ),
    );
  }
}
