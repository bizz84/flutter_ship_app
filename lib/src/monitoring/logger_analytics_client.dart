import 'dart:async';
import 'dart:developer';
import 'dart:collection';

import 'package:flutter_ship_app/src/monitoring/analytics_client.dart';

class LoggerAnalyticsClient implements AnalyticsClient {
  const LoggerAnalyticsClient();

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    log('${getCurrentMethodName()}($enabled)');
    log('setAnalyticsCollectionEnabled($enabled)');
  }

  @override
  Future<void> trackAppOpen() async {
    log(getCurrentMethodName());
    //log('trackAppOpen');
  }

  @override
  Future<void> trackCompleteTask(int completedCount) async {
    log(getCurrentMethodName());
    //log('trackCompleteTask(completedCount: $completedCount)');
  }

  @override
  Future<void> trackCreateApp() async {
    log(getCurrentMethodName());
    //log('trackCreateApp');
  }

  @override
  Future<void> trackDeleteApp() async {
    log(getCurrentMethodName());
    //log('trackDeleteApp');
  }

  @override
  Future<void> trackEditApp() async {
    log(getCurrentMethodName());
    //log('trackEditApp');
  }

  @override
  Future<void> trackNewAppHome() async {
    log(getCurrentMethodName());
    //log('trackNewAppHome');
  }

  @override
  Future<void> trackNewAppOnboarding() async {
    log(getCurrentMethodName());
    //log('trackNewAppOnboarding');
  }
}

/// Helper function to extract the current method name from the stack trace
String getCurrentMethodName() {
  final frames = StackTrace.current.toString().split('\n');
  // The second frame in the stack trace contains the current method
  final frame = frames.elementAtOrNull(1);
  if (frame != null) {
    // Extract the method name from the frame. For example, given this input string:
    // #1      LoggerAnalyticsClient.trackAppOpen (package:flutter_ship_app/src/monitoring/logger_analytics_client.dart:28:9)
    // The code will return: LoggerAnalyticsClient.trackAppOpen
    final tokens = frame
        .replaceAll('<anonymous closure>', '<anonymous_closure>')
        .split(' ');
    final methodName = tokens.elementAtOrNull(tokens.length - 2);
    if (methodName != null) {
      // if the class name is included, remove it, otherwise return as is
      final methodTokens = methodName.split('.');
      // ignore_for_file:avoid-unsafe-collection-methods
      return methodTokens.length >= 2 &&
              methodTokens[1] != '<anonymous_closure>'
          ? (methodTokens.elementAtOrNull(1) ?? '')
          : methodName;
    }
  }
  return '';
}
