import 'dart:async';
import 'dart:developer';

import 'package:flutter_ship_app/src/monitoring/analytics_client.dart';

class LoggerAnalyticsClient implements AnalyticsClient {
  const LoggerAnalyticsClient();

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    log('setAnalyticsCollectionEnabled($enabled)');
  }

  @override
  Future<void> trackAppOpen() async {
    log('trackAppOpen');
  }

  @override
  Future<void> trackNewAppHome() async {
    log('trackNewAppHome');
  }

  @override
  Future<void> trackNewAppOnboarding() async {
    log('trackNewAppOnboarding');
  }

  @override
  Future<void> trackCreateApp() async {
    log('trackCreateApp');
  }

  @override
  Future<void> trackEditApp() async {
    log('trackEditApp');
  }

  @override
  Future<void> trackDeleteApp() async {
    log('trackDeleteApp');
  }

  @override
  Future<void> trackCompleteTask(int completedCount) async {
    log('trackCompleteTask(completedCount: $completedCount)');
  }

  @override
  Future<void> trackInAppReviewRequest({
    required int completedTasksCount,
    required int inAppReviewCount,
  }) async {
    log('trackInAppReviewRequest(completedTasksCount: $completedTasksCount, inAppRatingPromptCount: $inAppReviewCount)');
  }
}
