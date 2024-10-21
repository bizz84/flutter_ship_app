import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/env/flavor.dart';
import 'package:flutter_ship_app/src/common_widgets/responsive_center_scrollable.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';
import 'package:flutter_ship_app/src/utils/package_info_provider.dart';
import 'package:flutter_ship_app/src/utils/string_hardcoded.dart';

/// The settings screen of the app
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider).requireValue;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'.hardcoded),
      ),
      body: ResponsiveCenterScrollable(
        child: ListView(
          children: [
            gapH32,
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.p20),
                child: Image.asset(
                  'assets/common/app-icon-transparent.png',
                  height: 120,
                  semanticLabel: 'App Icon'.hardcoded,
                ),
              ),
            ),
            gapH12,
            AppTitleWidget(appName: packageInfo.appName),
            gapH8,
            Text(
              'Version ${packageInfo.version} (${packageInfo.buildNumber})'
                  .hardcoded,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            gapH32,
            const Divider(height: 1),
            const ThemeSelectorListTile(),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}

class AppTitleWidget extends StatelessWidget {
  const AppTitleWidget({super.key, required this.appName});
  final String appName;

  @override
  Widget build(BuildContext context) {
    // * On web, the PackageInfo.appName will return "flutter_ship_app"
    // * This code ensures we show the correct app name depending on the flavor
    final webAppName = switch (getFlavor()) {
      Flavor.prod => 'Flutter Ship'.hardcoded,
      Flavor.stg => 'Flutter Ship Stg'.hardcoded,
      Flavor.dev => 'Flutter Ship Dev'.hardcoded,
    };
    return Text(
      kIsWeb ? webAppName : appName,
      textAlign: TextAlign.center,
    );
  }
}

class ThemeSelectorListTile extends ConsumerWidget {
  const ThemeSelectorListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Theme mode'.hardcoded),
          gapH8,
          SegmentedButton<ThemeMode>(
            multiSelectionEnabled: false,
            emptySelectionAllowed: false,
            showSelectedIcon: false,
            selected: {themeMode},
            onSelectionChanged: (Set<ThemeMode> newSelection) {
              ref
                  .read(appThemeModeNotifierProvider.notifier)
                  // ignore:avoid-unsafe-collection-methods
                  .setThemeMode(newSelection.single);
            },
            segments: ThemeMode.values
                .map<ButtonSegment<ThemeMode>>((ThemeMode theme) {
              // Capitalize first letter
              final label =
                  theme.name[0].toUpperCase() + theme.name.substring(1);
              return ButtonSegment<ThemeMode>(
                value: theme,
                label: Text(label),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
