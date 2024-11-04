import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum Flavor { dev, stg, prod }

/// Global function to return the current flavor
Flavor getFlavor() {
  // * On iOS/Android, appFlavor is supported and set with the --flavor option
  // * On web, appFlavor is not supported so we read a separate WEB_FLAVOR
  // * variable and set it with --dart-define WEB_FLAVOR=dev|stg|prod
  const webFlavor = String.fromEnvironment('WEB_FLAVOR');
  const flavor = kIsWeb ? webFlavor : appFlavor;
  return switch (flavor) {
    'prod' => Flavor.prod,
    'stg' => Flavor.stg,
    'dev' => Flavor.dev,
    null || '' => Flavor.dev, // * if not specified or empty, default to dev
    _ => throw UnsupportedError('Invalid flavor: $flavor'),
  };
}

// ignore_for_file:no-equal-switch-expression-cases,avoid-nullable-interpolation
