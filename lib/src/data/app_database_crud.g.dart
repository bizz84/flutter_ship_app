// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_crud.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateDatabaseFromJsonTemplateHash() =>
    r'b026e6f473d285a70f950b21fe5ea0172a8377d8';

/// See also [updateDatabaseFromJsonTemplate].
@ProviderFor(updateDatabaseFromJsonTemplate)
final updateDatabaseFromJsonTemplateProvider = FutureProvider<void>.internal(
  updateDatabaseFromJsonTemplate,
  name: r'updateDatabaseFromJsonTemplateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateDatabaseFromJsonTemplateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpdateDatabaseFromJsonTemplateRef = FutureProviderRef<void>;
String _$loadAllEpicsAndTasksHash() =>
    r'76ae7136fab9101a3c77e3d0b45769e2579ab551';

/// See also [loadAllEpicsAndTasks].
@ProviderFor(loadAllEpicsAndTasks)
final loadAllEpicsAndTasksProvider =
    AutoDisposeFutureProvider<List<EpicEntity>>.internal(
  loadAllEpicsAndTasks,
  name: r'loadAllEpicsAndTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loadAllEpicsAndTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LoadAllEpicsAndTasksRef
    = AutoDisposeFutureProviderRef<List<EpicEntity>>;
String _$appsListHash() => r'581c54ea512d276d0f0352ff0aac61bf4e24452c';

/// See also [appsList].
@ProviderFor(appsList)
final appsListProvider = AutoDisposeStreamProvider<List<AppEntity>>.internal(
  appsList,
  name: r'appsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppsListRef = AutoDisposeStreamProviderRef<List<AppEntity>>;
String _$appByIdHash() => r'f1236f4881910d3fa3421bce0a0083c15e652bc9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [appById].
@ProviderFor(appById)
const appByIdProvider = AppByIdFamily();

/// See also [appById].
class AppByIdFamily extends Family<AsyncValue<AppEntity?>> {
  /// See also [appById].
  const AppByIdFamily();

  /// See also [appById].
  AppByIdProvider call(
    int id,
  ) {
    return AppByIdProvider(
      id,
    );
  }

  @override
  AppByIdProvider getProviderOverride(
    covariant AppByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'appByIdProvider';
}

/// See also [appById].
class AppByIdProvider extends AutoDisposeStreamProvider<AppEntity?> {
  /// See also [appById].
  AppByIdProvider(
    int id,
  ) : this._internal(
          (ref) => appById(
            ref as AppByIdRef,
            id,
          ),
          from: appByIdProvider,
          name: r'appByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appByIdHash,
          dependencies: AppByIdFamily._dependencies,
          allTransitiveDependencies: AppByIdFamily._allTransitiveDependencies,
          id: id,
        );

  AppByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    Stream<AppEntity?> Function(AppByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AppByIdProvider._internal(
        (ref) => create(ref as AppByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<AppEntity?> createElement() {
    return _AppByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AppByIdRef on AutoDisposeStreamProviderRef<AppEntity?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _AppByIdProviderElement
    extends AutoDisposeStreamProviderElement<AppEntity?> with AppByIdRef {
  _AppByIdProviderElement(super.provider);

  @override
  int get id => (origin as AppByIdProvider).id;
}

String _$watchTasksForAppAndEpicHash() =>
    r'9a29ca9174f29189049b303fca1b206cd54d9e86';

/// See also [watchTasksForAppAndEpic].
@ProviderFor(watchTasksForAppAndEpic)
const watchTasksForAppAndEpicProvider = WatchTasksForAppAndEpicFamily();

/// See also [watchTasksForAppAndEpic].
class WatchTasksForAppAndEpicFamily
    extends Family<AsyncValue<List<TaskEntity>>> {
  /// See also [watchTasksForAppAndEpic].
  const WatchTasksForAppAndEpicFamily();

  /// See also [watchTasksForAppAndEpic].
  WatchTasksForAppAndEpicProvider call({
    required int projectId,
    required int epicId,
  }) {
    return WatchTasksForAppAndEpicProvider(
      projectId: projectId,
      epicId: epicId,
    );
  }

  @override
  WatchTasksForAppAndEpicProvider getProviderOverride(
    covariant WatchTasksForAppAndEpicProvider provider,
  ) {
    return call(
      projectId: provider.projectId,
      epicId: provider.epicId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'watchTasksForAppAndEpicProvider';
}

/// See also [watchTasksForAppAndEpic].
class WatchTasksForAppAndEpicProvider
    extends AutoDisposeStreamProvider<List<TaskEntity>> {
  /// See also [watchTasksForAppAndEpic].
  WatchTasksForAppAndEpicProvider({
    required int projectId,
    required int epicId,
  }) : this._internal(
          (ref) => watchTasksForAppAndEpic(
            ref as WatchTasksForAppAndEpicRef,
            projectId: projectId,
            epicId: epicId,
          ),
          from: watchTasksForAppAndEpicProvider,
          name: r'watchTasksForAppAndEpicProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchTasksForAppAndEpicHash,
          dependencies: WatchTasksForAppAndEpicFamily._dependencies,
          allTransitiveDependencies:
              WatchTasksForAppAndEpicFamily._allTransitiveDependencies,
          projectId: projectId,
          epicId: epicId,
        );

  WatchTasksForAppAndEpicProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
    required this.epicId,
  }) : super.internal();

  final int projectId;
  final int epicId;

  @override
  Override overrideWith(
    Stream<List<TaskEntity>> Function(WatchTasksForAppAndEpicRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchTasksForAppAndEpicProvider._internal(
        (ref) => create(ref as WatchTasksForAppAndEpicRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
        epicId: epicId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<TaskEntity>> createElement() {
    return _WatchTasksForAppAndEpicProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchTasksForAppAndEpicProvider &&
        other.projectId == projectId &&
        other.epicId == epicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);
    hash = _SystemHash.combine(hash, epicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchTasksForAppAndEpicRef
    on AutoDisposeStreamProviderRef<List<TaskEntity>> {
  /// The parameter `projectId` of this provider.
  int get projectId;

  /// The parameter `epicId` of this provider.
  int get epicId;
}

class _WatchTasksForAppAndEpicProviderElement
    extends AutoDisposeStreamProviderElement<List<TaskEntity>>
    with WatchTasksForAppAndEpicRef {
  _WatchTasksForAppAndEpicProviderElement(super.provider);

  @override
  int get projectId => (origin as WatchTasksForAppAndEpicProvider).projectId;
  @override
  int get epicId => (origin as WatchTasksForAppAndEpicProvider).epicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
