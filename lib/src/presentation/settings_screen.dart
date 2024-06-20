import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                child: Image.asset('assets/common/app-icon.png', height: 120),
              ),
            ),
            gapH12,
            Text(
              kIsWeb ? 'Flutter Ship'.hardcoded : packageInfo.appName,
              textAlign: TextAlign.center,
            ),
            gapH8,
            Text(
              'Version ${packageInfo.version}'.hardcoded,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            gapH32,
            const Divider(height: 1),
            const ThemeSelectorListTile(),
            const Divider(height: 1),
            // ListTile(
            //   title: Text('Website'.hardcoded),
            //   // TODO: Update with the correct URL
            //   onTap: () => _openLink('https://fluttertips.dev', ref),
            //   trailing: const Icon(Icons.chevron_right),
            // ),
            // const Divider(height: 1),
            // ListTile(
            //   title: Text('Privacy Policy'.hardcoded),
            //   // TODO: Update with the correct URL
            //   onTap: () => _openLink('https://fluttertips.dev/privacy', ref),
            //   trailing: const Icon(Icons.chevron_right),
            // ),
            // const Divider(height: 1),
            // ListTile(
            //   title: Text('Terms of Use'.hardcoded),
            //   // TODO: Update with the correct URL
            //   onTap: () => _openLink('https://fluttertips.dev/terms', ref),
            //   trailing: const Icon(Icons.chevron_right),
            // ),
            // const Divider(height: 1),
          ],
        ),
      ),
    );
  }

  // Future<void> _openLink(String url, WidgetRef ref) async {
  //   final uri = Uri.parse(url);
  //   await ref.read(urlLauncherProvider).launch(uri);
  // }
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
