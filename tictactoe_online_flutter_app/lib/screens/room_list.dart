import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/socket_controller.dart';

class RoomList extends StatelessWidget {
  const RoomList({super.key});
  static String routeName = '/RoomList';

  @override
  Widget build(BuildContext context) {
    SocketController socketController = Get.put(SocketController());

    socketController.getRoomList();
    socketController.createRoomSuccessListener(context);

    socketController.joinRoomSuccessListener();

    debugPrint('RoomList ${socketController.rooms.length}');
    debugPrint('RoomList ${socketController.rooms}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room List'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //const SizedBox(width: double.infinity),
            Text('Your ID : ${socketController.socketId}'),
            SizedBox(
              height: Get.height * 0.8,
              child: Center(
                child: ListView.builder(
                  itemCount: socketController.rooms.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                            'Room ${index + 1}: ${socketController.rooms[index]['_id']}'),
                        trailing: IconButton(
                          onPressed: () {
                            socketController.joinRoom(
                                'player2', socketController.rooms[index]);
                          },
                          icon: const Icon(Icons.chevron_right),
                        ),
                        onTap: () => socketController.joinRoom(
                            'player2', socketController.rooms[index]),
                        shape: const StadiumBorder(),
                        tileColor: Color.fromARGB(255, 51, 51, 51),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
