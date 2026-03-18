#!/usr/bin/env bash
set -e
echo "Building GooglePro release APK..."
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter build apk --release
mkdir -p outputs
cp build/app/outputs/flutter-apk/app-release.apk outputs/GooglePro-release.apk
echo "APK ready: outputs/GooglePro-release.apk"
ls -lh outputs/GooglePro-release.apk
