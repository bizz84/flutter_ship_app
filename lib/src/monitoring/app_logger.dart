import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_logger.g.dart';

class AppLogger {
  const AppLogger();

  // ignore:avoid-unnecessary-futures,avoid-redundant-async
  FutureOr<void> logException(Object exception, StackTrace? stackTrace) async {
    if (kReleaseMode) {
      // TODO: Error monitoring
    } else {
      log(exception.toString());
    }
  }
}

@riverpod
AppLogger appLogger(AppLoggerRef ref) {
  return const AppLogger();
}
