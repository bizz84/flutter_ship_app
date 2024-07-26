import 'dart:async';
import 'dart:developer';

import 'package:flutter_ship_app/src/monitoring/analytics_client.dart';

class LoggerAnalyticsClient implements AnalyticsClient {
  const LoggerAnalyticsClient();

  static const _name = 'Event';

  @override
  Future<void> trackScreenView(String routeName, String action) async {
    log('trackScreenView($routeName, $action)', name: 'Navigation');
  }

  @override
  Future<void> trackNewAppHome() async {
    log('trackNewAppHome', name: _name);
  }

  @override
  Future<void> trackNewAppOnboarding() async {
    log('trackNewAppOnboarding', name: _name);
  }

  @override
  Future<void> trackAppCreated() async {
    log('trackAppCreated', name: _name);
  }

  @override
  Future<void> trackAppUpdated() async {
    log('trackAppUpdated', name: _name);
  }

  @override
  Future<void> trackAppDeleted() async {
    log('trackAppDeleted', name: _name);
  }

  @override
  Future<void> trackTaskCompleted(int completedCount) async {
    log('trackTaskCompleted(completedCount: $completedCount)', name: _name);
  }
}
