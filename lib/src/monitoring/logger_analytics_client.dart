import 'dart:async';
import 'dart:developer';

import 'package:flutter_ship_app/src/monitoring/analytics_client.dart';

class LoggerAnalyticsClient implements AnalyticsClient {
  const LoggerAnalyticsClient();

  static const _name = 'Event';

  @override
  Future<void> trackAppOpen() async {
    log('trackAppOpen', name: _name);
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
  Future<void> trackCreateApp() async {
    log('trackCreateApp', name: _name);
  }

  @override
  Future<void> trackEditApp() async {
    log('trackEditApp', name: _name);
  }

  @override
  Future<void> trackDeleteApp() async {
    log('trackDeleteApp', name: _name);
  }

  @override
  Future<void> trackCompleteTask(int completedCount) async {
    log('trackCompleteTask(completedCount: $completedCount)', name: _name);
  }
}
