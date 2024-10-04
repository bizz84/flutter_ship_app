import 'package:dio/dio.dart';
import 'package:flutter_ship_app/src/utils/dio_provider.dart';
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
  const GistClient({required this.dio});
  final Dio dio;

  /// Fetch the JSON template from the Gist URL defined above
  // * No serialization is done here as the parsing happens when loading the
  // * data in the database
  Future<String> fetchJsonTemplate() async {
    final response = await dio.get(_gistTemplateUrl);
    return response.data;
  }
}

@Riverpod(keepAlive: true)
GistClient gistClient(GistClientRef ref) {
  final dio = ref.watch(dioProvider);
  return GistClient(dio: dio);
}

// ignore_for_file:avoid-throw-in-catch-block
