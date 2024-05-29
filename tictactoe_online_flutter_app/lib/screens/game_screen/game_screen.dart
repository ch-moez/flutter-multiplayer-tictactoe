import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../controllers/room_controller.dart';
import '../../controllers/socket_controller.dart';
import '../../provider/room_data_provider.dart';
import '../../util/socket_methods.dart';
import 'widgets/scoreboard.dart';
import 'widgets/tictactoe_board.dart';
import 'widgets/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //final SocketMethods _socketMethods = SocketMethods();

  SocketController socketController = Get.put(SocketController());

  @override
  void initState() {
    super.initState();
    /* _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context); */

    socketController.updateRoomListener(context);
    socketController.updatePlayersStateListener(context);
    socketController.pointIncreaseListener(context);
    socketController.endGameListener(context);

    //socketController.joinRoomSuccessListener();
  }

  @override
  Widget build(BuildContext context) {
    RoomController roomController = Get.put(RoomController());
    //RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${roomController.player1.nickname} VS ${roomController.player2.nickname}'),
      ),
      //body: roomDataProvider.roomData['isJoin']
      //body: roomController.roomData['isJoin']
      body: roomController.roomData.isNotEmpty &&
              roomController.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Scoreboard(),
                  const TicTacToeBoard(),
                  Text(
                      //'${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
                      '${roomController.roomData['turn']['nickname']}\'s turn'),
                  //Text('Your \'s turn'),
                ],
              ),
            ),
    );
  }
}
