import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/env/flavor.dart';
import 'package:flutter_ship_app/env/env.dart';
import 'package:flutter_ship_app/src/common_widgets/responsive_center_scrollable.dart';
import 'package:flutter_ship_app/src/common_widgets/show_alert_dialog.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/data/app_database_seed.dart';
import 'package:flutter_ship_app/src/monitoring/collect_usage_statistics_store.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';
import 'package:flutter_ship_app/src/utils/in_app_review_provider.dart';
import 'package:flutter_ship_app/src/utils/package_info_provider.dart';
import 'package:flutter_ship_app/src/utils/string_hardcoded.dart';
import 'package:flutter_ship_app/src/utils/url_launcher_provider.dart';

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
            const CollectUsageStatisticsListTile(),
            const Divider(height: 1),
            const SendFeedbackTile(),
            const Divider(height: 1),
            if (!kIsWeb) ...[
              const RateOnAppStoreTile(),
              const Divider(height: 1),
              // * No need to show the website links on Flutter web
              ListTile(
                title: const Text('Website'),
                onTap: () => _openLink(
                    'https://bizz84.github.io/flutter-ship-landing-page/', ref),
                trailing: const Icon(Icons.chevron_right),
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text('Privacy Policy'),
                onTap: () => _openLink(
                    'https://bizz84.github.io/flutter-ship-landing-page/privacy/',
                    ref),
                trailing: const Icon(Icons.chevron_right),
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text('Terms of Use'),
                onTap: () => _openLink(
                    'https://bizz84.github.io/flutter-ship-landing-page/terms/',
                    ref),
                trailing: const Icon(Icons.chevron_right),
              ),
              const Divider(height: 1),
            ],
            ShowLicensesTile(),
            const Divider(height: 1),
            if (getFlavor() != Flavor.prod) ...[
              ResetTestDataTile(),
              const Divider(height: 1),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _openLink(String url, WidgetRef ref) async {
    final uri = Uri.parse(url);
    await ref.read(urlLauncherProvider).launch(uri);
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
                label: Semantics(
                  identifier: 'theme-${theme.name}',
                  child: Text(label),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CollectUsageStatisticsListTile extends ConsumerWidget {
  const CollectUsageStatisticsListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(collectUsageStatisticsStoreProvider);
    return ListTile(
      title: Text('Collect anonymous usage statistics'.hardcoded),
      trailing: Semantics(
        label: 'Anonymous usage statistics toggle'.hardcoded,
        value: state ? 'Enabled'.hardcoded : 'Disabled'.hardcoded,
        child: Switch.adaptive(
          value: state,
          onChanged: (value) {
            ref
                .read(collectUsageStatisticsStoreProvider.notifier)
                .setCollectUsageStatistics(value);
          },
        ),
      ),
    );
  }
}

class SendFeedbackTile extends StatelessWidget {
  const SendFeedbackTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Send feedback'.hardcoded),
      onTap: () {
        BetterFeedback.of(context).showAndUploadToSentry();
      },
    );
  }
}

class RateOnAppStoreTile extends ConsumerWidget {
  const RateOnAppStoreTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text('Leave app store review'.hardcoded),
      onTap: () async {
        await ref
            .read(inAppReviewProvider)
            .openStoreListing(appStoreId: Env.appStoreId);
      },
    );
  }
}

class ShowLicensesTile extends ConsumerWidget {
  const ShowLicensesTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text('Show licenses'.hardcoded),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => showLicensePage(context: context),
    );
  }
}

class ResetTestDataTile extends ConsumerWidget {
  const ResetTestDataTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      identifier: 'reset-test-data-tile',
      child: ListTile(
        title: Text('Reset test data'.hardcoded),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          await ref.read(appDatabaseProvider).deleteAllApps();
          await ref.read(appDatabaseProvider).seedDatabase();
          await showAlertDialog(
            // ignore: use_build_context_synchronously
            context: context,
            title: 'Data Updated'.hardcoded,
            content: 'All the data has been reset'.hardcoded,
            defaultActionText: 'OK'.hardcoded,
          );
        },
      ),
    );
  }
}
