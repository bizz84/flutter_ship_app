import 'package:flutter/foundation.dart';
import 'package:flutter_ship_app/src/monitoring/analytics_client.dart';
import 'package:flutter_ship_app/src/monitoring/logger_analytics_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_facade.g.dart';

// https://refactoring.guru/design-patterns/facade
class AnalyticsFacade implements AnalyticsClient {
  const AnalyticsFacade(this.clients);
  final List<AnalyticsClient> clients;

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) => _dispatch(
        (c) => c.setAnalyticsCollectionEnabled(enabled),
      );

  @override
  Future<void> trackScreenView(String routeName, String action) => _dispatch(
        (c) => c.trackScreenView(routeName, action),
      );

  @override
  Future<void> trackNewAppHome() => _dispatch(
        (c) => c.trackNewAppHome(),
      );

  @override
  Future<void> trackNewAppOnboarding() => _dispatch(
        (c) => c.trackNewAppOnboarding(),
      );

  @override
  Future<void> trackAppCreated() => _dispatch(
        (c) => c.trackAppCreated(),
      );

  @override
  Future<void> trackAppUpdated() => _dispatch(
        (c) => c.trackAppUpdated(),
      );

  @override
  Future<void> trackAppDeleted() => _dispatch(
        (c) => c.trackAppDeleted(),
      );

  @override
  Future<void> trackTaskCompleted(int completedCount) => _dispatch(
        (c) => c.trackTaskCompleted(completedCount),
      );

  Future<void> _dispatch(
      Future<void> Function(AnalyticsClient client) work) async {
    for (var client in clients) {
      await work(client);
    }
  }
}

@Riverpod(keepAlive: true)
AnalyticsFacade analyticsFacade(AnalyticsFacadeRef ref) {
  return const AnalyticsFacade([
    if (!kReleaseMode) LoggerAnalyticsClient(),
  ]);
}
