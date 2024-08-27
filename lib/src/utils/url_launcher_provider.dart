import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'url_launcher_provider.g.dart';

/// A simple wrapper for the url_launcher package
class UrlLauncher {
  const UrlLauncher();

  static const _name = 'URL Launcher';

  Future<bool> launch(Uri uri,
      {LaunchMode mode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(uri)) {
      log('Launching URL: $uri', name: _name);
      return await launchUrl(uri, mode: mode);
    } else {
      log('Cannot launch URL: $uri', name: _name);
      throw UrlLauncherException(uri);
    }
  }
}

class UrlLauncherException implements Exception {
  const UrlLauncherException(this.uri);
  final Uri uri;

  String get message => 'Cannot launch URL: ${uri.toString()}';

  @override
  String toString() => 'UrlLauncherException(${uri.toString()})';
}

@riverpod
UrlLauncher urlLauncher(UrlLauncherRef ref) {
  return const UrlLauncher();
}
