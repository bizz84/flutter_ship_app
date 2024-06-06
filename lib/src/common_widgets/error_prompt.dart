import 'package:flutter/material.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/utils/string_hardcoded.dart';

/// Custom error prompt widget with retry button
class ErrorPrompt extends StatelessWidget {
  const ErrorPrompt({
    super.key,
    required this.message,
    this.onRetry,
  });
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectableText(
            message,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
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
