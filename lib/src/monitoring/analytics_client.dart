abstract class AnalyticsClient {
  Future<void> trackAppOpen();
  Future<void> trackNewAppOnboarding();
  Future<void> trackNewAppHome();
  Future<void> trackCreateApp();
  Future<void> trackEditApp();
  Future<void> trackDeleteApp();
  Future<void> trackCompleteTask(int completedCount);
}
