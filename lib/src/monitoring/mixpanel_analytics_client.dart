import 'package:flutter_ship_app/env/env.dart';
import 'package:flutter_ship_app/src/monitoring/analytics_client.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mixpanel_analytics_client.g.dart';

class MixpanelAnalyticsClient implements AnalyticsClient {
  const MixpanelAnalyticsClient(this._mixpanel);
  final Mixpanel _mixpanel;

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    if (enabled) {
      _mixpanel.optInTracking();
    } else {
      _mixpanel.optOutTracking();
    }
  }

  @override
  Future<void> identifyUser(String userId) async {
    await _mixpanel.identify(userId);
  }

  @override
  Future<void> resetUser() async {
    await _mixpanel.reset();
  }

  @override
  Future<void> trackScreenView(String routeName, String action) async {
    await _mixpanel.track('Screen View',
        properties: {'name': routeName, 'action': action});
  }

  @override
  Future<void> trackNewAppHome() async {
    await _mixpanel.track('New App (Home)');
  }

  @override
  Future<void> trackNewAppOnboarding() async {
    await _mixpanel.track('New App (Onboarding)');
  }

  @override
  Future<void> trackAppCreated() async {
    await _mixpanel.track('App Created');
  }

  @override
  Future<void> trackAppUpdated() async {
    await _mixpanel.track('App Updated');
  }

  @override
  Future<void> trackAppDeleted() async {
    await _mixpanel.track('App Deleted');
  }

  @override
  Future<void> trackTaskCompleted(int completedCount) async {
    await _mixpanel
        .track('Task Completed', properties: {'count': completedCount});
  }
}

@Riverpod(keepAlive: true)
Future<MixpanelAnalyticsClient> mixpanelAnalyticsClient(
    MixpanelAnalyticsClientRef ref) async {
  final mixpanel = await Mixpanel.init(
    Env.mixpanelProjectToken,
    trackAutomaticEvents: true,
  );
  return MixpanelAnalyticsClient(mixpanel);
}
