import 'package:flutter/material.dart';

import '../resources/socket_methods.dart';

class SocketIsConnected extends StatelessWidget {
  SocketIsConnected({super.key});
  final SocketMethods _socketMethods = SocketMethods();

  @override
  Widget build(BuildContext context) {
    return _socketMethods.socketClient.connected == false
        ? const Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Connecting to server...'),
            ],
          )
        : const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('Server Connected !'));
  }
}
