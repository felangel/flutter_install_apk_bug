#!/bin/bash -ex

# Create a temporary directory
TEMP_DIR=$(mktemp -d -t 'workspace-XXXXX')
cd "$TEMP_DIR"

# Create a new empty flutter project
flutter create e2e_test --empty --platforms android
cd e2e_test

# Create a new release on Android
flutter build appbundle --release

# Download bundletool 1.17.1
curl -L -o bundletool.jar https://github.com/google/bundletool/releases/download/1.17.1/bundletool-all-1.17.1.jar

# Build a universal APK
java -jar bundletool.jar build-apks --overwrite --bundle=build/app/outputs/bundle/release/app-release.aab --output=outputs/my_app.apks --mode=universal

# Install the APK on a device
java -jar bundletool.jar install-apks --allow-downgrade --apks=outputs/my_app.apks
