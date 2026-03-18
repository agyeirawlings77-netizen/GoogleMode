# GooglePro Setup Guide

## 1. Prerequisites
- Flutter SDK 3.22+
- Android Studio Hedgehog (2023.1.1+)
- Java JDK 17
- Git

## 2. Clone & Install
```bash
git clone <repo-url>
cd GooglePro
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## 3. Firebase Setup
The `google-services.json` is pre-configured. If replacing:
1. Create project at console.firebase.google.com
2. Add Android app with package `com.rawlings.GooglePro`
3. Download `google-services.json` → `android/app/`
4. Enable: Authentication, Firestore, RTDB, Storage, FCM, Crashlytics

## 4. Manufacturer Auto-Start (Required for Auto-Connect)
For Infinix/Tecno/itel/Samsung/Xiaomi etc., the app prompts users to whitelist GooglePro in their battery manager. The `ManufacturerAutoStartHelper.kt` handles this.

## 5. Build
```bash
# Debug
flutter run

# Release APK
flutter build apk --release
```

## 6. CI/CD
Push to `main` → GitHub Actions builds automatically.
Set `ANTHROPIC_API_KEY` in repo secrets for AI auto-fix.
