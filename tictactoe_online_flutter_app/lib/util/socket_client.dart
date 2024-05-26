import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;
  bool isConnected = false;
  static String socketId = '';

  //static String socketUrl = 'http://localhost:3000';
  static String socketUrl = 'http://tic-tac-toe-server.node.how-much-now.com';

  void connect() {
    if (GetPlatform.isAndroid) {
      //socketUrl = 'http://192.168.1.93:3001'; // for Android emulator en local
    }
    debugPrint("socketUrl :  $socketUrl");

    socket = io.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    if (isConnected) {
      return;
    }
    socket!.connect()
      ..on('connect', (_) {
        isConnected = true;
        debugPrint('Socket connect');
        socketId = socket!.id ?? '';
        debugPrint('Socket id : $socketId');
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
    connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }

  static Future<String> getIpAddress() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (!addr.isLoopback && addr.type == InternetAddressType.IPv4) {
          return addr.address;
        }
      }
    }
    return 'localhost';
  }
}
