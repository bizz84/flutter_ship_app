import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_logger.g.dart';

class ErrorLogger {
  const ErrorLogger();

  // ignore:avoid-unnecessary-futures,avoid-redundant-async
  FutureOr<void> logException(Object exception, StackTrace? stackTrace) async {
    // TODO: Error monitoring
    log(exception.toString(),
        name: 'Exception', error: exception, stackTrace: stackTrace);
  }
}

@riverpod
ErrorLogger errorLogger(ErrorLoggerRef ref) {
  return const ErrorLogger();
}
