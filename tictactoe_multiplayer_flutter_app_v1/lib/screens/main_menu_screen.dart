import 'package:flutter/material.dart';
import 'package:tictactoe_multiplayer_flutter_app/responsive/responsive.dart';
import 'package:tictactoe_multiplayer_flutter_app/screens/create_room_screen.dart';
import 'package:tictactoe_multiplayer_flutter_app/screens/join_room_screen.dart';
import 'package:tictactoe_multiplayer_flutter_app/widgets/custom_button.dart';

import '../resources/socket_methods.dart';
import '../widgets/custom_text.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  //final SocketMethods _socketMethods = SocketMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            const CustomText(
              text: 'Tic Tac Toe',
              shadows: [
                Shadow(blurRadius: 40, color: Colors.blue),
              ],
              fontSize: 50,
            ),
            const SizedBox(height: 10),
            const CustomText(
              text: 'Online Multiplayer Game',
              shadows: [
                Shadow(blurRadius: 40, color: Colors.blue),
              ],
              fontSize: 20,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomButton(
                onTap: () => createRoom(context),
                text: 'Create Room',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomButton(
                onTap: () => joinRoom(context),
                text: 'Join Room',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
