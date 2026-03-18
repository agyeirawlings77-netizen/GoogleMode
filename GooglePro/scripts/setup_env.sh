#!/usr/bin/env bash
# GooglePro Development Environment Setup
set -e
echo "Setting up GooglePro development environment..."

# Check Flutter
if ! command -v flutter &>/dev/null; then
  echo "Flutter not found. Install from https://flutter.dev/docs/get-started/install"; exit 1
fi

# Check Java
if ! command -v java &>/dev/null; then
  echo "Java not found. Install JDK 17."; exit 1
fi

# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Check Firebase
echo ""
echo "Ensure google-services.json is in android/app/ before building."
echo "Setup complete. Run: flutter run"
