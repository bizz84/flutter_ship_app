#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'dev', 'stg', or 'prod'."
  exit 1
fi

case $1 in
  dev)
    flutterfire config \
      --project=flutter-ship-dev \
      --out=lib/firebase_options_dev.dart \
      --ios-bundle-id=com.codewithandrea.flutterShipApp.dev \
      --ios-out=ios/flavors/dev/GoogleService-Info.plist \
      --android-package-name=com.codewithandrea.flutter_ship_app.dev \
      --android-out=android/app/src/dev/google-services.json
    ;;
  stg)
    flutterfire config \
      --project=flutter-ship-stg \
      --out=lib/firebase_options_stg.dart \
      --ios-bundle-id=com.codewithandrea.flutterShipApp.stg \
      --ios-out=ios/flavors/stg/GoogleService-Info.plist \
      --android-package-name=com.codewithandrea.flutter_ship_app.stg \
      --android-out=android/app/src/stg/google-services.json
    ;;
  prod)
    flutterfire config \
      --project=flutter-ship-prod \
      --out=lib/firebase_options_prod.dart \
      --ios-bundle-id=com.codewithandrea.flutterShipApp \
      --ios-out=ios/flavors/prod/GoogleService-Info.plist \
      --android-package-name=com.codewithandrea.flutter_ship_app \
      --android-out=android/app/src/prod/google-services.json
    ;;
  *)
    echo "Error: Invalid environment specified. Use 'dev', 'stg', or 'prod'."
    exit 1
    ;;
esac
