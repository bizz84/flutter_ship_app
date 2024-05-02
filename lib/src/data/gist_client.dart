import 'package:dio/dio.dart';
import 'package:flutter_ship_app/src/utils/logger_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gist_client.g.dart';

// * Change these values if you want to fetch your own template from elsewhere
const _owner = 'bizz84';
const _gistId = '5c2ee79cd103bd43ce97b4d7fcfed103';
const _templateName = 'app_release_template.json';
const _gistTemplateUrl =
    'https://gist.githubusercontent.com/$_owner/$_gistId/raw/$_templateName';

/// An API client class for fetching the JSON template from a GitHub gist
class GistClient {
  GistClient({required this.dio});
  final Dio dio;

  /// Fetch the JSON template from the Gist URL defined above
  // * No serialization is done here as the parsing happens when loading the
  // * data in the database
  Future<String> fetchJsonTemplate() async {
    try {
      final response = await dio.get(_gistTemplateUrl);
      final statusCode = response.statusCode;
      if (statusCode != null && (statusCode < 200 || statusCode >= 300)) {
        throw HttpException(
          statusCode: statusCode,
          message: response.data,
        );
      }
      return response.data;
    } on DioException catch (e) {
      throw FailedLookupException(e.message ?? 'Unknown error');
    } catch (e) {
      throw FailedLookupException(e.toString());
    }
  }
}

@riverpod
GistClient gistClient(GistClientRef ref) {
  final dio = Dio();
  dio.interceptors.add(LoggerInterceptor());
  return GistClient(dio: dio);
}

@riverpod
Future<String> fetchJsonTemplate(FetchJsonTemplateRef ref) {
  return ref.watch(gistClientProvider).fetchJsonTemplate();
}

/// Exceptions supported by the GistClient
sealed class APIException implements Exception {
  String get message;
  String get displayMessage;
  bool get canRetry;
}

class HttpException extends APIException {
  HttpException({this.statusCode, required this.message});
  final int? statusCode;
  @override
  final String message;

  @override
  String get displayMessage => 'Loading failed.\n${toString()}';

  @override
  bool get canRetry => true;

  @override
  String toString() => 'HttpException($statusCode, $message)';
}

class FailedLookupException extends APIException {
  FailedLookupException(this.message);

  @override
  final String message;

  @override
  String get displayMessage =>
      'Loading failed.\nCheck your Internet connection.';

  @override
  bool get canRetry => true;

  @override
  String toString() => 'FailedLookupException($message)';
}
