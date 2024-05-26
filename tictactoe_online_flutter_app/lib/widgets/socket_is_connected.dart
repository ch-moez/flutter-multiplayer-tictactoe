import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../util/socket_methods.dart';

class SocketIsConnected extends StatelessWidget {
  SocketIsConnected({super.key});
  //late IO.Socket socket;
  final SocketMethods socketMethods = SocketMethods();

  @override
  Widget build(BuildContext context) {
    return socketMethods.isConnected == false
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
