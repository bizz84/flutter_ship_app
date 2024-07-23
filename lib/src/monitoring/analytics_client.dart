import 'dart:async';

abstract class AnalyticsClient {
  Future<void> setAnalyticsCollectionEnabled(bool enabled);

  Future<void> trackAppOpen();
  Future<void> trackNewAppOnboarding();
  Future<void> trackNewAppHome();
  Future<void> trackCreateApp();
  Future<void> trackEditApp();
  Future<void> trackDeleteApp();
  Future<void> trackCompleteTask(int completedCount);
}
