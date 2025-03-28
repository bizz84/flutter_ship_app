import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/monitoring/ab_testing/firebase_remote_config_data_source.dart';
import 'package:flutter_ship_app/src/monitoring/ab_testing/remote_value_data_source.dart';
import 'package:flutter_ship_app/src/utils/firebase_remote_config_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ab_test_repository.g.dart';

class ABTestRepository {
  ABTestRepository({required this.dataSource});
  final RemoteValueDataSource dataSource;

  bool addNewAppUsingFAB() => dataSource.getBool('new_app_using_fab');

  // TODO: Add methods for other experiments
}

@Riverpod(keepAlive: true)
ABTestRepository abTestRepository(Ref ref) {
  // * Ensure provider is eagerly initialized when using requireValue
  final remoteConfig = ref.watch(firebaseRemoteConfigProvider).requireValue;
  return ABTestRepository(
    dataSource: FirebaseRemoteConfigDataSource(remoteConfig),
  );
}
