import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'error_logger.g.dart';

class ErrorLogger {
  const ErrorLogger();

  FutureOr<void> logException(Object exception, StackTrace? stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
    log(exception.toString(),
        name: 'Exception', error: exception, stackTrace: stackTrace);
  }
}

@riverpod
ErrorLogger errorLogger(ErrorLoggerRef ref) {
  return const ErrorLogger();
}
