import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/env/flavor.dart';
import 'package:flutter_ship_app/src/utils/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_config_gist_client.g.dart';

class RemoteConfigGistData {
  RemoteConfigGistData({required this.requiredVersion});
  final String requiredVersion;

  factory RemoteConfigGistData.fromJson(Map<String, dynamic> json) {
    final requiredVersion = json['config']?['required_version'];
    if (requiredVersion == null) {
      throw FormatException('required_version not found in JSON: $json');
    }
    return RemoteConfigGistData(requiredVersion: requiredVersion);
  }
}

/// An API client class for fetching a remote config JSON from a GitHub gist
class RemoteConfigGistClient {
  const RemoteConfigGistClient({required this.dio, required this.flavor});
  final Dio dio;
  final Flavor flavor;

  /// Fetch the remote config JSON
  Future<RemoteConfigGistData> fetchRemoteConfig() async {
    // TODO: Update this with your GitHub username
    const owner = 'bizz84';
    // TODO: Update this with your gist IDs
    final gistId = switch (flavor) {
      Flavor.dev => 'dc229fcb401d29a57d2e1a372f3b1443',
      Flavor.stg => '063b6e2eace97c6c3444b252dd996967',
      Flavor.prod => '8fd9d8d87508f223230963a3387168c9'
    };
    final fileName = 'flutter_ship_remote_config.json';
    final url =
        'https://gist.githubusercontent.com/$owner/$gistId/raw/$fileName';
    final response = await dio.get(url);
    final jsonData = jsonDecode(response.data);
    return RemoteConfigGistData.fromJson(jsonData);
  }
}

@Riverpod(keepAlive: true)
RemoteConfigGistClient remoteConfigGistClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return RemoteConfigGistClient(dio: dio, flavor: getFlavor());
}
