abstract class AnalyticsClient {
  Future<void> setAnalyticsCollectionEnabled(bool enabled);

  Future<void> trackScreenView(String routeName, String action);

  Future<void> trackNewAppOnboarding();
  Future<void> trackNewAppHome();
  Future<void> trackCreateApp();
  Future<void> trackEditApp();
  Future<void> trackDeleteApp();
  Future<void> trackCompleteTask(int completedCount);
}
