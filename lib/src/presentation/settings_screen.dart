import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/responsive_center_scrollable.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/monitoring/collect_usage_statistics_store.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';
import 'package:flutter_ship_app/src/utils/canvas_kit/is_canvas_kit.dart';
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
                  'assets/common/app-icon.png',
                  height: 120,
                  semanticLabel: 'App Icon'.hardcoded,
                ),
              ),
            ),
            gapH12,
            Text(
              kIsWeb ? 'Flutter Ship'.hardcoded : packageInfo.appName,
              textAlign: TextAlign.center,
            ),
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
            if (!kIsWeb || isCanvasKitRenderer()) ...[
              const SendFeedbackTile(),
              const Divider(height: 1),
            ],
          ],
        ),
      ),
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
