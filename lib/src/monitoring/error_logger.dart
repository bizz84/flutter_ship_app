import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
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

@Riverpod(keepAlive: true)
ErrorLogger errorLogger(Ref ref) {
  return const ErrorLogger();
}
