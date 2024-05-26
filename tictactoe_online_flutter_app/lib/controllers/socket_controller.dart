import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/game_screen.dart';
import '../screens/room_list.dart';
import '../util/game_methods.dart';
import '../util/socket_client.dart';
import '../util/socket_methods.dart';
import '../util/utils.dart';
import 'room_controller.dart';

class SocketController extends GetxController {
  final _socketClient = SocketClient.instance.socket!;

  //Socket get socketClient => _socketClient;

  final SocketMethods _socketMethods = SocketMethods();
  RxBool isLoading = false.obs; // 0
  List rooms = [];
  RxString socketId = SocketClient.socketId.obs;

  RoomController roomController = Get.put(RoomController());

  void createRoomSuccessListener(BuildContext context) {
    isLoading.value = true;
    //_socketMethods.createRoomSuccessListener(context);
    _socketClient.on('createRoomSuccess', (room) {
      //Navigator.pushNamed(context, GameScreen.routeName);
      rooms.add(room);
      isLoading.value = false;
      debugPrint('createRoomSuccess');
      debugPrint('createRoomSuccess - room : $room');
      debugPrint('rooms: $rooms');
      //Get.to(const RoomList());
    });
  }

  void getRoomList() {
    debugPrint('socketId : $socketId');

    _socketClient.emit('getRoomList', {});

    _socketClient.on('getRoomList', (roomsFromServer) {
      isLoading.value = true;

      debugPrint('roomsFromServer: $roomsFromServer');
      if (roomsFromServer.length > 0 &&
          rooms.length != roomsFromServer.length) {
        rooms = roomsFromServer;
        Get.forceAppUpdate();
      }

      update();
      //Get.forceAppUpdate();
      isLoading.value = false;
    });
  }

  void updateRoomsList() {
    isLoading.value = true;
    _socketClient.on('updateRooms', (roomsFromServer) {
      rooms = roomsFromServer.obs;
      update();
    });
    isLoading.value = false;
  }

  void createRoom(String nickname) {
    isLoading.value = true;
    _socketMethods.createRoom(nickname);
  }

  void joinRoom(String nickname, String roomId) {
    debugPrint('joinRoom: $nickname, $roomId');
    if (nickname.isEmpty || roomId.isEmpty) return;
    isLoading.value = true;
    _socketMethods.joinRoom(socketId.value, roomId);
    Get.to(const GameScreen());
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    isLoading.value = true;
    _socketMethods.tapGrid(index, roomId, displayElements);
  }

  void updateRoomData(Map<String, dynamic> data) {
    isLoading.value = true;
    //_socketMethods.updateRoomData(data);
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    isLoading.value = true;
    //_socketMethods.updatePlayer1(player1Data);
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    isLoading.value = true;
    //_socketMethods.updatePlayer2(player2Data);
  }

  void updateDisplayElements(int index, String choice) {
    isLoading.value = true;
    //_socketMethods.updateDisplayElements(index, choice);
  }

  void setFilledBoxesTo0() {
    isLoading.value = true;
    //_socketMethods.setFilledBoxesTo0();
  }

  void endGame(BuildContext context) {
    isLoading.value = true;
    //_socketMethods.endGame(context);
  }

  void errorOccured(BuildContext context) {
    isLoading.value = true;
    //_socketMethods.errorOccured(context);
  }

//======================Listener=====================
  void joinRoomSuccessListener() {
    _socketClient.on('joinRoomSuccess', (room) {
      debugPrint('joinRoomSuccess room : $room');
      //Navigator.pushNamed(context, GameScreen.routeName);
      Get.to(const GameScreen(), arguments: room);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      //Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(playerData[0]);
      roomController.updatePlayer1(playerData[0]);

      //Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(playerData[1]);
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
      //RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
      var roomDataProvider = roomController;

      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
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
        roomController.updatePlayer1(playerData);
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
