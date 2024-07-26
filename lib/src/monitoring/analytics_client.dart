abstract class AnalyticsClient {
  Future<void> trackScreenView(String routeName, String action);

  Future<void> trackNewAppOnboarding();
  Future<void> trackNewAppHome();
  Future<void> trackAppCreated();
  Future<void> trackAppUpdated();
  Future<void> trackAppDeleted();
  Future<void> trackTaskCompleted(int completedCount);
}
