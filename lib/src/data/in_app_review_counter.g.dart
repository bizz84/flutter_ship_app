// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_app_review_counter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inAppReviewHash() => r'8b46ea01bee9d2a9afc1f8ca79e8b88479d93eef';

/// See also [inAppReview].
@ProviderFor(inAppReview)
final inAppReviewProvider = Provider<InAppReview>.internal(
  inAppReview,
  name: r'inAppReviewProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$inAppReviewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InAppReviewRef = ProviderRef<InAppReview>;
String _$inAppReviewCounterHash() =>
    r'0523e6d3a134fae8c852bef8165e5380c7e99cdd';

/// See also [InAppReviewCounter].
@ProviderFor(InAppReviewCounter)
final inAppReviewCounterProvider =
    AutoDisposeNotifierProvider<InAppReviewCounter, int>.internal(
  InAppReviewCounter.new,
  name: r'inAppReviewCounterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inAppReviewCounterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InAppReviewCounter = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
