import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../../controllers/room_controller.dart';
import '../../../provider/room_data_provider.dart';
import '../../../util/socket_methods.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  //void tapped(int index, RoomDataProvider roomDataProvider) {
  void tapped(int index, roomDataProvider) {
    _socketMethods.tapGrid(
      index,
      roomDataProvider.roomData['_id'],
      roomDataProvider.displayElements,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    RoomController roomController = Get.put(RoomController());

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.6,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        //absorbing: roomDataProvider.roomData['turn']['socketID'] !=
        absorbing: roomController.roomData['turn']['socketID'] !=
            _socketMethods.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              //onTap: () => tapped(index, roomDataProvider),
              onTap: () => tapped(index, roomController),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      //roomDataProvider.displayElements[index],
                      roomController.displayElements[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 100,
                          shadows: [
                            Shadow(
                              blurRadius: 40,
                              color:
                                  //roomDataProvider.displayElements[index] == 'O'
                                  roomController.displayElements[index] == 'O'
                                      ? Colors.red
                                      : Colors.blue,
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
