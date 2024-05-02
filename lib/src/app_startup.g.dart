// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_startup.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appStartupHash() => r'd17e2b7ccff426a81b18938421d5134ba82fff7e';

/// App startup provider and widget (below)
/// For more info, read: https://codewithandrea.com/articles/robust-app-initialization-riverpod/
///
/// Copied from [appStartup].
@ProviderFor(appStartup)
final appStartupProvider = AutoDisposeFutureProvider<void>.internal(
  appStartup,
  name: r'appStartupProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appStartupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppStartupRef = AutoDisposeFutureProviderRef<void>;
String _$updateDatabaseFromJsonTemplateHash() =>
    r'b680ef3f21e64a71f1b3a884ada192773e03ba12';

/// Provider to load the initial data from JSON
///
/// Copied from [updateDatabaseFromJsonTemplate].
@ProviderFor(updateDatabaseFromJsonTemplate)
final updateDatabaseFromJsonTemplateProvider =
    AutoDisposeFutureProvider<void>.internal(
  updateDatabaseFromJsonTemplate,
  name: r'updateDatabaseFromJsonTemplateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateDatabaseFromJsonTemplateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpdateDatabaseFromJsonTemplateRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
