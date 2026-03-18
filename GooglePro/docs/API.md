# GooglePro Signaling API

Base URL: `https://googlepro-signaling.onrender.com/api/v1`
WebSocket: `wss://googlepro-signaling.onrender.com/ws`

## Authentication
All requests require Firebase ID Token:
```
Authorization: Bearer <firebase_id_token>
```

## WebSocket Messages

### Connect
```json
{"type": "connect", "uid": "user_id", "token": "firebase_token"}
```

### Send Offer
```json
{"type": "offer", "from": "uid_a", "to": "uid_b", "payload": {"sdp": {...}}}
```

### Send Answer
```json
{"type": "answer", "from": "uid_b", "to": "uid_a", "payload": {"sdp": {...}}}
```

### Send ICE Candidate
```json
{"type": "candidate", "from": "uid_a", "to": "uid_b", "payload": {"candidate": {...}}}
```

### Heartbeat
```json
{"type": "ping"}
// Server responds: {"type": "pong"}
```

## Firebase RTDB Structure
```
presence/
  {uid}/
    {deviceId}/
      online: boolean
      lastSeen: timestamp

signals/
  {uid}/
    offer: {...}
    answer: {...}
    candidates/
      {pushId}: {...}

auto_connect_signals/
  {uid}/
    {deviceId}/
      from: string
      action: "connect"
      ts: timestamp

chat/
  {sessionId}/
    messages/
      {messageId}: {...}
    typing/
      {uid}: boolean

presence/
  {uid}/
    location:
      latitude: number
      longitude: number
      timestamp: number
```
