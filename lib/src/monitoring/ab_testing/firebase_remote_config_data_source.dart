import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_ship_app/src/monitoring/ab_testing/remote_value_data_source.dart';

class FirebaseRemoteConfigDataSource implements RemoteValueDataSource {
  FirebaseRemoteConfigDataSource(this._remoteConfig);
  final FirebaseRemoteConfig _remoteConfig;

  @override
  bool getBool(String key) => _remoteConfig.getBool(key);

  @override
  double getDouble(String key) => _remoteConfig.getDouble(key);

  @override
  int getInt(String key) => _remoteConfig.getInt(key);

  @override
  String getString(String key) => _remoteConfig.getString(key);
}
