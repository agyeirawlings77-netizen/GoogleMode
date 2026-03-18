# GooglePro Architecture

## Overview
GooglePro follows Clean Architecture with BLoC state management.

## Layers

### Presentation (Flutter)
- **UI**: Screens built with Flutter widgets + GoRouter navigation
- **BLoC/Cubit**: State management (flutter_bloc)
- **DI**: GetIt + Injectable for dependency injection

### Domain
- **Entities**: Pure Dart classes (UserEntity, DeviceEntity, etc.)
- **Use Cases**: Single-responsibility business logic
- **Repository Interfaces**: Abstract contracts

### Data
- **Models**: Extend entities, handle JSON serialization
- **Repository Impl**: Concrete implementations
- **Datasources**: Firebase (remote) + SharedPrefs/SecureStorage (local)
- **Mappers**: Convert between layers

## Key Services

| Service | Purpose |
|---------|---------|
| WebRtcService | P2P connection management |
| SignalingService | Firebase RTDB offer/answer/ICE |
| TrustedDeviceManager | Secure storage of paired devices |
| AutoConnectService | Firebase presence watching |
| NotificationService | FCM + local notifications |
| LocationService | Geolocator + Firebase sharing |
| FileTransferService | Firebase Storage uploads |

## Auto-Connect Flow
1. Device A pairs with Device B via QR → saved as TrustedDevice
2. On boot: BootReceiver → AppForegroundService → AutoConnectWorker (15min)
3. AutoConnectService watches Firebase presence for trusted devices
4. Device B comes online → AutoConnectReceiver fires → signal sent
5. SessionBloc starts WebRTC connection silently
6. Notification: "Connected to Device B"

## WebRTC Flow
1. Caller: createPeerConnection → startScreenCapture → createOffer → sendOffer (Firebase)
2. Callee: receives offer → setRemoteDescription → createAnswer → sendAnswer
3. Both: exchange ICE candidates via Firebase RTDB
4. ICE negotiation completes → P2P stream established

## State Management
Every feature has: State → Event → BLoC pattern
```
UI → dispatches Event → BLoC handles → emits new State → UI rebuilds
```
