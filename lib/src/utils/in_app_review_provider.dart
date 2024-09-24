import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'in_app_review_provider.g.dart';

@riverpod
InAppReview inAppReview(InAppReviewRef ref) {
  return InAppReview.instance;
}
