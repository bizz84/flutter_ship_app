class Env {
  static String get sentryDsn => const String.fromEnvironment('SENTRY_DSN');
  static String get mixpanelProjectToken =>
      const String.fromEnvironment('MIXPANEL_PROJECT_TOKEN');
}
