import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/utils/string_hardcoded.dart';

/// Custom error prompt widget with retry button
class ErrorPrompt extends StatelessWidget {
  const ErrorPrompt({
    super.key,
    required this.exception,
    this.onRetry,
  });
  final Object exception;
  final VoidCallback? onRetry;

  ({String message, bool canRetry}) get errorDetails {
    return (message: exception.toString(), canRetry: true);
  }

  @override
  Widget build(BuildContext context) {
    final (:message, :canRetry) = errorDetails;
    log(message);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          if (canRetry) ...[
            gapH12,
            ElevatedButton(
              onPressed: onRetry,
              child: Text('Retry'.hardcoded),
            ),
          ],
        ],
      ),
    );
  }
}
