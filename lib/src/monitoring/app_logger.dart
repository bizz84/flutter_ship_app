import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'app_logger.g.dart';

class AppLogger {
  const AppLogger();

  FutureOr<void> logException(Object exception, StackTrace? stackTrace) async {
    if (kReleaseMode) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    } else {
      log(exception.toString());
    }
  }
}

@riverpod
AppLogger appLogger(AppLoggerRef ref) {
  return const AppLogger();
}
