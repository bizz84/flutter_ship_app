import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'in_app_review_provider.g.dart';

@riverpod
InAppReview inAppReview(Ref ref) {
  return InAppReview.instance;
}
