import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../controllers/room_controller.dart';
import '../controllers/socket_controller.dart';
import '../provider/room_data_provider.dart';
import '../util/socket_methods.dart';
import '../views/scoreboard.dart';
import '../views/tictactoe_board.dart';
import '../views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  SocketController socketController = Get.put(SocketController());

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);

    /* socketController.updateRoomListener(context);
    socketController.updatePlayersStateListener(context);
    socketController.pointIncreaseListener(context);
    socketController.endGameListener(context);

    socketController.joinRoomSuccessListener(); */
  }

  @override
  Widget build(BuildContext context) {
    //RoomController roomController = Get.put(RoomController());
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    //bool isJoin = false;

    return Scaffold(
      appBar: AppBar(),
      body: roomDataProvider.roomData['isJoin']
          //body: roomController.roomData.isNotEmpty //&& roomController.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Scoreboard(),
                  const TicTacToeBoard(),
                  Text(
                      '${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
                  //Text('Your \'s turn'),
                ],
              ),
            ),
    );
  }
}
