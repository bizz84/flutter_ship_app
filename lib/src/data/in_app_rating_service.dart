import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/utils/in_app_review_provider.dart';
import 'package:flutter_ship_app/src/utils/shared_preferences_provider.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'in_app_rating_service.g.dart';

/// Helper class used to show the in-app rating prompt when a certain number of
/// tasks has been completed
class InAppRatingService {
  const InAppRatingService(this.ref);
  final Ref ref;

  // * Used to show the prompt
  InAppReview get _inAppReview => ref.read(inAppReviewProvider);
  // * Used to keep track of how many times we've requested
  // * a review from the user
  SharedPreferences get _sharedPreferences =>
      ref.read(sharedPreferencesProvider).requireValue;

  static const key = 'in_app_rating_prompt_count';

  int get _inAppReviewRequestCount => _sharedPreferences.getInt(key) ?? 0;

  /// Requests a review if certain conditions are met
  Future<void> requestReviewIfNeeded({required int completedTasksCount}) async {
    // * Don't show rating prompt on web (not supported)
    if (kIsWeb) {
      return;
    }
    // * If we can show a review dialog
    if (await _inAppReview.isAvailable()) {
      // * Use an exponential backoff function:
      // * - 1st request after 5 completed tasks
      // * - 2nd request after another 10 completed tasks
      // * - 3rd request after another 20 completed tasks
      if (completedTasksCount >= 5 && _inAppReviewRequestCount == 0 ||
          completedTasksCount >= 15 && _inAppReviewRequestCount == 1 ||
          completedTasksCount >= 35 && _inAppReviewRequestCount == 2) {
        // * Request the review
        await _inAppReview.requestReview();
        // * Increment the count
        await _sharedPreferences.setInt(key, _inAppReviewRequestCount + 1);
      }
    }
  }
}

@riverpod
InAppRatingService inAppRatingService(InAppRatingServiceRef ref) {
  return InAppRatingService(ref);
}
