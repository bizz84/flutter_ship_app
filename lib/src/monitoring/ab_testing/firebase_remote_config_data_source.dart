import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigDataSource {
  FirebaseRemoteConfigDataSource(this._remoteConfig);
  final FirebaseRemoteConfig _remoteConfig;

  bool getBool(String key) => _remoteConfig.getBool(key);

  double getDouble(String key) => _remoteConfig.getDouble(key);

  int getInt(String key) => _remoteConfig.getInt(key);

  String getString(String key) => _remoteConfig.getString(key);
}
