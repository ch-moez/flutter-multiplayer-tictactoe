import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:webscoket_app/screens/room_list.dart';
import 'package:webscoket_app/util/utils.dart';

import '../controllers/room_controller.dart';
import '../provider/room_data_provider.dart';
import '../screens/game_screen/game_screen.dart';
import 'game_methods.dart';
import 'socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;
  bool get isConnected => _socketClient.connected;

  RoomController roomController = Get.put(RoomController());

  // EMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    try {
      _socketClient.on('createRoomSuccess', (room) {
        //Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);

        roomController.updateRoomData(room);
        //Navigator.pushNamed(context, GameScreen.routeName);
        //Navigator.pushNamed(context, RoomList.routeName);
        Get.off(const GameScreen());
        //Get.off(const RoomList());
        //Get.back();
      });
    } catch (e) {
      debugPrint('error in createRoomSuccessListener \n : $e');
    }
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      //Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
      roomController.updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      /* Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
        playerData[0],
      ); */
      roomController.updatePlayer1(playerData[0]);

      /* Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
        playerData[1],
      ); */
      roomController.updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      //Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(data);
      roomController.updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      /*RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );*/
      roomController.updateDisplayElements(
        data['index'],
        data['choice'],
      );

      //roomDataProvider.updateRoomData(data['room']);
      roomController.updateRoomData(data['room']);
      // check winnner
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      //var roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
      var roomDataProvider = roomController;

      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialog(context, '${playerData['nickname']} won the game!');
      Navigator.popUntil(context, (route) => false);
    });
  }
}
