// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_crud.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchAllEpicsAndTasksHash() =>
    r'50bbbca378b07557d0ec3d7ffb4dadff45d75320';

/// See also [fetchAllEpicsAndTasks].
@ProviderFor(fetchAllEpicsAndTasks)
final fetchAllEpicsAndTasksProvider =
    AutoDisposeFutureProvider<List<Epic>>.internal(
  fetchAllEpicsAndTasks,
  name: r'fetchAllEpicsAndTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAllEpicsAndTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAllEpicsAndTasksRef = AutoDisposeFutureProviderRef<List<Epic>>;
String _$watchAppsListHash() => r'7011592389f0180cb95870f141200af0b72e9f74';

/// See also [watchAppsList].
@ProviderFor(watchAppsList)
final watchAppsListProvider = AutoDisposeStreamProvider<List<App>>.internal(
  watchAppsList,
  name: r'watchAppsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchAppsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchAppsListRef = AutoDisposeStreamProviderRef<List<App>>;
String _$watchAppByIdHash() => r'740bb7a74220220c5b2d2e493255300e9b997d2c';

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
class WatchAppByIdFamily extends Family<AsyncValue<App?>> {
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
class WatchAppByIdProvider extends AutoDisposeStreamProvider<App?> {
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
    Stream<App?> Function(WatchAppByIdRef provider) create,
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
  AutoDisposeStreamProviderElement<App?> createElement() {
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

mixin WatchAppByIdRef on AutoDisposeStreamProviderRef<App?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _WatchAppByIdProviderElement
    extends AutoDisposeStreamProviderElement<App?> with WatchAppByIdRef {
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
    r'6a6a5a60c9b5155c50eeb6dd18326967e1b6348d';

/// See also [watchTasksForAppAndEpic].
@ProviderFor(watchTasksForAppAndEpic)
const watchTasksForAppAndEpicProvider = WatchTasksForAppAndEpicFamily();

/// See also [watchTasksForAppAndEpic].
class WatchTasksForAppAndEpicFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [watchTasksForAppAndEpic].
  const WatchTasksForAppAndEpicFamily();

  /// See also [watchTasksForAppAndEpic].
  WatchTasksForAppAndEpicProvider call({
    required int appId,
    required String epicId,
  }) {
    return WatchTasksForAppAndEpicProvider(
      appId: appId,
      epicId: epicId,
    );
  }

  @override
  WatchTasksForAppAndEpicProvider getProviderOverride(
    covariant WatchTasksForAppAndEpicProvider provider,
  ) {
    return call(
      appId: provider.appId,
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
    extends AutoDisposeStreamProvider<List<Task>> {
  /// See also [watchTasksForAppAndEpic].
  WatchTasksForAppAndEpicProvider({
    required int appId,
    required String epicId,
  }) : this._internal(
          (ref) => watchTasksForAppAndEpic(
            ref as WatchTasksForAppAndEpicRef,
            appId: appId,
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
          appId: appId,
          epicId: epicId,
        );

  WatchTasksForAppAndEpicProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.appId,
    required this.epicId,
  }) : super.internal();

  final int appId;
  final String epicId;

  @override
  Override overrideWith(
    Stream<List<Task>> Function(WatchTasksForAppAndEpicRef provider) create,
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
        appId: appId,
        epicId: epicId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Task>> createElement() {
    return _WatchTasksForAppAndEpicProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchTasksForAppAndEpicProvider &&
        other.appId == appId &&
        other.epicId == epicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, appId.hashCode);
    hash = _SystemHash.combine(hash, epicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchTasksForAppAndEpicRef on AutoDisposeStreamProviderRef<List<Task>> {
  /// The parameter `appId` of this provider.
  int get appId;

  /// The parameter `epicId` of this provider.
  String get epicId;
}

class _WatchTasksForAppAndEpicProviderElement
    extends AutoDisposeStreamProviderElement<List<Task>>
    with WatchTasksForAppAndEpicRef {
  _WatchTasksForAppAndEpicProviderElement(super.provider);

  @override
  int get appId => (origin as WatchTasksForAppAndEpicProvider).appId;
  @override
  String get epicId => (origin as WatchTasksForAppAndEpicProvider).epicId;
}

String _$watchCompletedTasksCountHash() =>
    r'1eb480633bc4887c55af38a932ce3b13b35d737d';

/// See also [watchCompletedTasksCount].
@ProviderFor(watchCompletedTasksCount)
const watchCompletedTasksCountProvider = WatchCompletedTasksCountFamily();

/// See also [watchCompletedTasksCount].
class WatchCompletedTasksCountFamily extends Family<AsyncValue<int>> {
  /// See also [watchCompletedTasksCount].
  const WatchCompletedTasksCountFamily();

  /// See also [watchCompletedTasksCount].
  WatchCompletedTasksCountProvider call({
    required int appId,
    String? epicId,
  }) {
    return WatchCompletedTasksCountProvider(
      appId: appId,
      epicId: epicId,
    );
  }

  @override
  WatchCompletedTasksCountProvider getProviderOverride(
    covariant WatchCompletedTasksCountProvider provider,
  ) {
    return call(
      appId: provider.appId,
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
    required int appId,
    String? epicId,
  }) : this._internal(
          (ref) => watchCompletedTasksCount(
            ref as WatchCompletedTasksCountRef,
            appId: appId,
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
          appId: appId,
          epicId: epicId,
        );

  WatchCompletedTasksCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.appId,
    required this.epicId,
  }) : super.internal();

  final int appId;
  final String? epicId;

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
        appId: appId,
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
        other.appId == appId &&
        other.epicId == epicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, appId.hashCode);
    hash = _SystemHash.combine(hash, epicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchCompletedTasksCountRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `appId` of this provider.
  int get appId;

  /// The parameter `epicId` of this provider.
  String? get epicId;
}

class _WatchCompletedTasksCountProviderElement
    extends AutoDisposeStreamProviderElement<int>
    with WatchCompletedTasksCountRef {
  _WatchCompletedTasksCountProviderElement(super.provider);

  @override
  int get appId => (origin as WatchCompletedTasksCountProvider).appId;
  @override
  String? get epicId => (origin as WatchCompletedTasksCountProvider).epicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
