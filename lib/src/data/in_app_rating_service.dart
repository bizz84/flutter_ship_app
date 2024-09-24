import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/utils/in_app_review_provider.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'in_app_rating_service.g.dart';

/// Helper class used to show the in-app rating prompt when a certain number of
/// tasks has been completed
class InAppRatingService {
  const InAppRatingService(this.ref);
  final Ref ref;

  // * Used to show the prompt
  InAppReview get _inAppReview => ref.read(inAppReviewProvider);

  /// Requests a review if certain conditions are met
  Future<void> requestReviewIfNeeded({required int completedTasksCount}) async {
    // * Don't show rating prompt on web (not supported)
    if (kIsWeb) {
      return;
    }
    // TODO: Only show prompt after a certain number of tasks has been completed
    // * If we can show a review dialog
    if (await _inAppReview.isAvailable()) {
      // * Request the review
      await _inAppReview.requestReview();
    }
  }
}

@riverpod
InAppRatingService inAppRatingService(InAppRatingServiceRef ref) {
  return InAppRatingService(ref);
}
