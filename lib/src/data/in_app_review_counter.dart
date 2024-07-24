import 'package:flutter/foundation.dart';
import 'package:flutter_ship_app/src/monitoring/analytics_facade.dart';
import 'package:flutter_ship_app/src/utils/shared_preferences_provider.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'in_app_review_counter.g.dart';

@Riverpod(keepAlive: true)
InAppReview inAppReview(InAppReviewRef ref) {
  return InAppReview.instance;
}

@riverpod
class InAppReviewCounter extends _$InAppReviewCounter {
  static const key = 'in_app_review_count';

  SharedPreferences get _sharedPreferences =>
      ref.watch(sharedPreferencesProvider).requireValue;
  int get _count => _sharedPreferences.getInt(key) ?? 0;

  @override
  int build() {
    return _count;
  }

  /// Requests an in-app review and increments the request count
  /// (Android, iOS, and macOS only)
  Future<void> requestReviewAndIncrementCount(int completedTasksCount) async {
    if (kIsWeb) {
      return; // nothing to do
    }
    final inAppReview = ref.read(inAppReviewProvider);
    if (await inAppReview.isAvailable()) {
      // Increment count
      _sharedPreferences.setInt(key, _count + 1);
      // Request review
      await inAppReview.requestReview();
      // Analytics
      ref.read(analyticsFacadeProvider).trackInAppReviewRequest(
            completedTasksCount: completedTasksCount,
            inAppReviewCount: _count,
          );
    }
  }
}
