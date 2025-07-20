import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  late IO.Socket socket;
  String? username;

  void connect({
    required String user,
    required Function(dynamic) onNewMessage,
    required Function(dynamic) onUserJoined,
    required Function(dynamic) onUserLeft,
  }) {
    username = user;
    final serverUrl = kIsWeb
        ? 'http://localhost:3000'
        : 'http://10.0.2.2:3000';

    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected');
      socket.emit('add user', username);
    });

    socket.on('login', (data) => print("Logged in: $data"));
    socket.on('new message', onNewMessage);
    socket.on('user joined', onUserJoined);
    socket.on('user left', onUserLeft);

    socket.onDisconnect((_) => print('Disconnected'));
  }

  void sendMessage(String message) {      //This is used For Sending Message
    socket.emit('new message', message);
  }

  void dispose() { // Its for Dispose the connection
    socket.disconnect();
  }
}