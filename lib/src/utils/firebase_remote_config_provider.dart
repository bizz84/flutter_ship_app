import 'dart:async';
import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/env/flavor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_remote_config_provider.g.dart';

@Riverpod(keepAlive: true)
Future<FirebaseRemoteConfig> firebaseRemoteConfig(Ref ref) async {
  // Fetch up to 5 times per hour
  // https://firebase.google.com/docs/remote-config/get-started?platform=ios#throttling
  final minimumFetchIntervalMinutes = getFlavor() == Flavor.prod ? 12 : 1;
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: Duration(minutes: minimumFetchIntervalMinutes),
  ));
  // Set default values (useful if app is offline on first launch)
  await remoteConfig.setDefaults({
    'required_version': '0.1.0',
  });
  // Strategy 3: Load new values for next startup
  // https://firebase.google.com/docs/remote-config/loading
  // 1. Immediately activate previously fetched values
  await remoteConfig.activate();
  // 2. Fetch new values (unawaited)
  unawaited(remoteConfig.fetch());
  StreamSubscription<RemoteConfigUpdate>? sub;
  if (!kIsWeb) {
    // 3. Add a real-time config update listener (non-web only)
    sub = remoteConfig.onConfigUpdated.listen((event) {
      // 4. Do nothing. The app will keep the downloaded values and activate them next time the app starts.
      log('Updated keys: ${event.updatedKeys}', name: 'Remote Config');
    });
  }
  // Log all values
  final allValues = remoteConfig
      .getAll()
      .map((key, value) => MapEntry(key, value.asString()));
  log('values: $allValues\nlastFetchStatus: ${remoteConfig.lastFetchStatus}, lastFetchTime: ${remoteConfig.lastFetchTime}',
      name: 'Remote Config');
  // Don't forget to cancel the subscription
  if (sub != null) {
    ref.onDispose(sub.cancel);
  }
  return remoteConfig;
}
