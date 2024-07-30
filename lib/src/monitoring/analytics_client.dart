abstract class AnalyticsClient {
  Future<void> setAnalyticsCollectionEnabled(bool enabled);

  Future<void> identifyUser(String userId);
  Future<void> resetUser();

  Future<void> trackScreenView(String routeName, String action);

  Future<void> trackNewAppOnboarding();
  Future<void> trackNewAppHome();
  Future<void> trackAppCreated();
  Future<void> trackAppUpdated();
  Future<void> trackAppDeleted();
  Future<void> trackTaskCompleted(int completedCount);
}
