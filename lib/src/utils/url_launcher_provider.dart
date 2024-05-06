import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'url_launcher_provider.g.dart';

/// A simple wrapper for the url_launcher package
class UrlLauncher {
  Future<bool> launch(Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        log('Launching URL: $uri');
        return await launchUrl(uri, mode: LaunchMode.platformDefault);
      } else {
        log('Cannot launch URL: $uri');
        // TODO: Error monitoring
        return false;
      }
    } catch (e) {
      log('Failed launching URL: $uri, $e');
      // TODO: Error monitoring
      return false;
    }
  }
}

@riverpod
UrlLauncher urlLauncher(UrlLauncherRef ref) {
  return UrlLauncher();
}
