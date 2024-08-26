import 'package:dio/dio.dart';
import 'package:flutter_ship_app/src/monitoring/logger_dio_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  dio.interceptors.add(LoggerDioInterceptor());
  return dio;
}
