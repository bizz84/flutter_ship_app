#!/bin/bash
# Script to build and upload the ipa file to App Store Connect

# Exit immediately if any command fails
set -e

# Check if the environment (e.g., dev, stg, prod) is provided as an argument
if [[ $# -eq 0 ]]; then
  echo "No environment specified. Use 'dev', 'stg', or 'prod'."
  exit 1
fi

FLAVOR=$1 # First argument specifies the flavor (e.g., dev, stg, prod)

# Validate that the API Key ID and Issuer ID are set
if [[ -z ${APP_STORE_CONNECT_KEY_ID} ]]; then
  echo "Key ID is missing. Please set APP_STORE_CONNECT_KEY_ID as an environment variable."
  exit 1
fi

if [[ -z ${APP_STORE_CONNECT_ISSUER_ID} ]]; then
  echo "Issuer ID is missing. Please set APP_STORE_CONNECT_ISSUER_ID as an environment variable."
  exit 1
fi

# Start from a clean slate
# This ensures that there's only one *.ipa inside build/ios/ipa when uploading with xcrun
flutter clean
flutter pub get

# Build the IPA file using Flutter
echo "Building the IPA for flavor: ${FLAVOR}..."
flutter build ipa --flavor ${FLAVOR} -t lib/main_${FLAVOR}.dart --dart-define-from-file=.env.${FLAVOR}

# Upload the IPA file to App Store Connect using xcrun
echo "Uploading the IPA to App Store Connect..."
xcrun altool --upload-app --type ios --file build/ios/ipa/*.ipa --apiKey ${APP_STORE_CONNECT_KEY_ID} --apiIssuer ${APP_STORE_CONNECT_ISSUER_ID}