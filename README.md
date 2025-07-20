# Real-time Chat Application (TechIndiaKa Assignment)

A real-time chat application built using Flutter that supports Socket.IO integration. This project is responsive and works seamlessly across both mobile and web platforms.

---

## Features

-  Real-time messaging
-  Show users joining/leaving
-  Typing indicator
-  Mobile + Web responsive layout
  
---

## Requirements:

- Flutter SDK
- Android Studio / Chrome
- Node.js
   
### Frontend
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Emulator or Chrome Browser
- VS Code or Android Studio

### Backend
- [Node.js](https://nodejs.org/)
- Basic terminal knowledge

---
## Socket.IO Event Details Used

The following socket events are integrated in the Flutter app via `SocketManager.dart`:

|   Event Name     |    Received                            |  Description                                                |  Emitted By        |
|------------------|----------------------------------------|-------------------------------------------------------------|---------------------|
| `add user`       | `String` (username)                    | Sent after connection to register a new user                | Client              |
| `login`          | `{ numUsers: Number }`                 | Server response to confirm login and return user count      | Server              |
| `new message`    | `String` (message)                     | Sends a new chat message to all users                       | Client → Server → Clients |
| `user joined`    | `{ username: String, numUsers: Number }` | Broadcasted when a new user joins                        | Server              |
| `user left`      | `{ username: String, numUsers: Number }` | Broadcasted when a user disconnects                      | Server              |
| `typing`         | `{ username: String }`                 | Notifies others that the user is typing                     | Client → Server → Clients |
| `stop typing`    | `{ username: String }`                 | Notifies others that the user stopped typing                | Client → Server → Clients |
| `disconnect`     | *none*                                 | Triggered when the user disconnects from the socket         | Client / Server     |

---

###  How These Events Are Used in the Flutter App

| Function in Code       | Socket Event        | Purpose                                  |
|------------------------|---------------------|------------------------------------------|
| `socket.emit('add user')`       | `add user`         | Registers a new username after connection |
| `socket.on('login')`            | `login`            | Handles login response from server        |
| `sendMessage(String message)`   | `new message`      | Sends a chat message                      |
| `onNewMessage()` callback       | `new message`      | Listens for incoming messages             |
| `startTyping()`                 | `typing`           | Emits typing event                        |
| `stopTyping()`                  | `stop typing`      | Emits stop typing event                   |
| `onUserJoined()` callback       | `user joined`      | Shows when a user joins                   |
| `onUserLeft()` callback         | `user left`        | Shows when a user leaves                  |
| `dispose()`                     | `disconnect`       | Disconnects socket on app close           |

---

 All socket logic is handled in the `SocketManager` class. The class ensures proper connection, event binding, and cleanup using `dispose()`.

##  Dependencies

Make sure to add the following in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  socket_io_client: ^2.0.0

---

## Clone and run the Socket.IO test server

git clone https://github.com/socketio/socket.io.git
cd socket.io/examples/chat
npm install
node index.js
- Server runs on http://localhost:3000

