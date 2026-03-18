# GooglePro — Remote Screen Share, Monitor & Control

A powerful Flutter Android app enabling remote device management, screen sharing, and monitoring with auto-connect support.

## Features
- 📱 **Remote Screen Share** — Real-time P2P screen viewing via WebRTC
- 🎮 **Remote Control** — Touch, swipe, type remotely on connected devices
- 🔗 **Auto-Connect** — Trusted devices reconnect automatically after reboot
- 📁 **File Transfer** — Send/receive files via Firebase Storage
- 💬 **Chat** — Real-time messaging during sessions
- 📞 **Voice Call** — Walkie-talkie and voice call modes
- 📍 **Location Tracking** — Real-time GPS with map view
- 👶 **Parental Controls** — Screen time, app blocking, schedules
- 🔒 **Security** — Biometric, PIN lock, intruder photos
- 🤖 **AI Assistant** — Powered by Google Gemini

## Setup

### Prerequisites
- Flutter 3.22+
- Java 17+
- Android Studio Hedgehog+
- Firebase project configured

### Quick Start
```bash
# Clone and setup
git clone https://github.com/rawlings/googlepro.git
cd googlepro/GooglePro
chmod +x scripts/setup_env.sh
./scripts/setup_env.sh
```

### Firebase Setup
1. Add `google-services.json` to `android/app/`
2. The file is already pre-configured with project credentials

### Build Release APK
```bash
./scripts/build_release.sh
# APK saved to outputs/GooglePro-release.apk
```

## CI/CD
GitHub Actions automatically builds on push to `main`:
- Runs `flutter build apk --release`
- Auto-fixes errors using Claude AI (up to 20 iterations)
- Commits APK to repository

## Architecture
```
lib/
├── core/           # Firebase, Network, DI, Utils, Theme
├── data/           # Models, Repositories, Datasources
├── domain/         # Entities, Use Cases, Interfaces
└── features/       # Feature modules (auth, dashboard, etc.)
    ├── auth/
    ├── dashboard/
    ├── device_management/
    ├── screen_capture/
    ├── remote_control/
    ├── file_transfer/
    ├── chat/
    ├── voice_call/
    ├── location/
    ├── parental_controls/
    ├── security/
    ├── app_lock/
    ├── ai_assistant/
    └── settings/
```

## Credentials (baked in — do NOT commit to public repos)
- Firebase Project: `pro-c76ee`
- Signaling: `wss://googlepro-signaling.onrender.com`
- TURN: `relay.metered.ca`
- Gemini: configured in AppConstants

## License
Private — All rights reserved by Rawlings.
