import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;
  bool isConnected = false;

  void connect() {
    if (isConnected) {
      return;
    }
    socket!.connect()
      ..on('connect', (_) {
        isConnected = true;
        debugPrint('Socket connect');
      })
      ..on('disconnect', (_) {
        isConnected = false;
        debugPrint('Socket disconnect');
      });

    socket!.onConnectError((data) {
      isConnected = false;
      debugPrint('Socket onConnectError');
      debugPrint('Socket onConnectError data: $data');
    });
    socket!.onConnectTimeout((data) {
      isConnected = false;
      debugPrint('Socket onConnectTimeout');
    });
  }

  SocketClient._internal() {
    socket = io.io('http://localhost:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    connect();
    //socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
