// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_crud.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchAllEpicsAndTasksHash() =>
    r'1ca2ce3a880a2e0c9964d595d5e5d85e85f5ca7e';

/// See also [fetchAllEpicsAndTasks].
@ProviderFor(fetchAllEpicsAndTasks)
final fetchAllEpicsAndTasksProvider =
    AutoDisposeFutureProvider<List<EpicEntity>>.internal(
  fetchAllEpicsAndTasks,
  name: r'fetchAllEpicsAndTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAllEpicsAndTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAllEpicsAndTasksRef
    = AutoDisposeFutureProviderRef<List<EpicEntity>>;
String _$watchAppsListHash() => r'8e11a97da45360f25a53cd9fc3c42b95f6f73ffc';

/// See also [watchAppsList].
@ProviderFor(watchAppsList)
final watchAppsListProvider =
    AutoDisposeStreamProvider<List<AppEntity>>.internal(
  watchAppsList,
  name: r'watchAppsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchAppsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchAppsListRef = AutoDisposeStreamProviderRef<List<AppEntity>>;
String _$watchAppByIdHash() => r'f933eff34afc9a0ebb6e59d3ea2e49be65713eec';

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

/// See also [watchAppById].
@ProviderFor(watchAppById)
const watchAppByIdProvider = WatchAppByIdFamily();

/// See also [watchAppById].
class WatchAppByIdFamily extends Family<AsyncValue<AppEntity?>> {
  /// See also [watchAppById].
  const WatchAppByIdFamily();

  /// See also [watchAppById].
  WatchAppByIdProvider call(
    int id,
  ) {
    return WatchAppByIdProvider(
      id,
    );
  }

  @override
  WatchAppByIdProvider getProviderOverride(
    covariant WatchAppByIdProvider provider,
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
  String? get name => r'watchAppByIdProvider';
}

/// See also [watchAppById].
class WatchAppByIdProvider extends AutoDisposeStreamProvider<AppEntity?> {
  /// See also [watchAppById].
  WatchAppByIdProvider(
    int id,
  ) : this._internal(
          (ref) => watchAppById(
            ref as WatchAppByIdRef,
            id,
          ),
          from: watchAppByIdProvider,
          name: r'watchAppByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchAppByIdHash,
          dependencies: WatchAppByIdFamily._dependencies,
          allTransitiveDependencies:
              WatchAppByIdFamily._allTransitiveDependencies,
          id: id,
        );

  WatchAppByIdProvider._internal(
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
    Stream<AppEntity?> Function(WatchAppByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchAppByIdProvider._internal(
        (ref) => create(ref as WatchAppByIdRef),
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
    return _WatchAppByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchAppByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchAppByIdRef on AutoDisposeStreamProviderRef<AppEntity?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _WatchAppByIdProviderElement
    extends AutoDisposeStreamProviderElement<AppEntity?> with WatchAppByIdRef {
  _WatchAppByIdProviderElement(super.provider);

  @override
  int get id => (origin as WatchAppByIdProvider).id;
}

String _$watchTotalTasksCountHash() =>
    r'8aefd5280417d21542f0c74a4e18d087aa67e6e7';

/// See also [watchTotalTasksCount].
@ProviderFor(watchTotalTasksCount)
final watchTotalTasksCountProvider = AutoDisposeStreamProvider<int>.internal(
  watchTotalTasksCount,
  name: r'watchTotalTasksCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchTotalTasksCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchTotalTasksCountRef = AutoDisposeStreamProviderRef<int>;
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

String _$watchCompletedTasksCountHash() =>
    r'1ca24044024bd58d12436f163415e2c8bc43a3f7';

/// See also [watchCompletedTasksCount].
@ProviderFor(watchCompletedTasksCount)
const watchCompletedTasksCountProvider = WatchCompletedTasksCountFamily();

/// See also [watchCompletedTasksCount].
class WatchCompletedTasksCountFamily extends Family<AsyncValue<int>> {
  /// See also [watchCompletedTasksCount].
  const WatchCompletedTasksCountFamily();

  /// See also [watchCompletedTasksCount].
  WatchCompletedTasksCountProvider call({
    required int projectId,
    int? epicId,
  }) {
    return WatchCompletedTasksCountProvider(
      projectId: projectId,
      epicId: epicId,
    );
  }

  @override
  WatchCompletedTasksCountProvider getProviderOverride(
    covariant WatchCompletedTasksCountProvider provider,
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
  String? get name => r'watchCompletedTasksCountProvider';
}

/// See also [watchCompletedTasksCount].
class WatchCompletedTasksCountProvider extends AutoDisposeStreamProvider<int> {
  /// See also [watchCompletedTasksCount].
  WatchCompletedTasksCountProvider({
    required int projectId,
    int? epicId,
  }) : this._internal(
          (ref) => watchCompletedTasksCount(
            ref as WatchCompletedTasksCountRef,
            projectId: projectId,
            epicId: epicId,
          ),
          from: watchCompletedTasksCountProvider,
          name: r'watchCompletedTasksCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchCompletedTasksCountHash,
          dependencies: WatchCompletedTasksCountFamily._dependencies,
          allTransitiveDependencies:
              WatchCompletedTasksCountFamily._allTransitiveDependencies,
          projectId: projectId,
          epicId: epicId,
        );

  WatchCompletedTasksCountProvider._internal(
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
  final int? epicId;

  @override
  Override overrideWith(
    Stream<int> Function(WatchCompletedTasksCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchCompletedTasksCountProvider._internal(
        (ref) => create(ref as WatchCompletedTasksCountRef),
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
  AutoDisposeStreamProviderElement<int> createElement() {
    return _WatchCompletedTasksCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchCompletedTasksCountProvider &&
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

mixin WatchCompletedTasksCountRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `projectId` of this provider.
  int get projectId;

  /// The parameter `epicId` of this provider.
  int? get epicId;
}

class _WatchCompletedTasksCountProviderElement
    extends AutoDisposeStreamProviderElement<int>
    with WatchCompletedTasksCountRef {
  _WatchCompletedTasksCountProviderElement(super.provider);

  @override
  int get projectId => (origin as WatchCompletedTasksCountProvider).projectId;
  @override
  int? get epicId => (origin as WatchCompletedTasksCountProvider).epicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
