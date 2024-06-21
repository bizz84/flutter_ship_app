import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ship_app/src/monitoring/logger_dio_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_dio/sentry_dio.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio();
  // * Only log network requests in debug mode
  if (kDebugMode) {
    dio.interceptors.add(LoggerDioInterceptor());
  }
  // * Add http breadcrumbs
  dio.addSentry();
  return dio;
}
