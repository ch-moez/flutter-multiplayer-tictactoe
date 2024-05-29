import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webscoket_app/screens/create_room_screen.dart';
import 'package:webscoket_app/screens/join_room_screen.dart';

import '../responsive/responsive.dart';
import '../util/socket_methods.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import 'room_list.dart';
import 'settings/settings_screen.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  final SocketMethods _socketMethods = SocketMethods();

  @override
  Widget build(BuildContext context) {
    String platformName = kIsWeb ? 'web' : Platform.operatingSystem;

    return Scaffold(
      appBar: AppBar(
        title: Text(platformName.toUpperCase()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Responsive(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
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
              const SizedBox(height: 10),
              CustomText(
                text: 'Your Platform : $platformName',
                shadows: const [
                  Shadow(blurRadius: 40, color: Colors.blue),
                ],
                fontSize: 15,
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CustomButton(
                  onTap: () => Get.to(const RoomList()),
                  text: 'Room List',
                ),
              ),
              const SizedBox(height: 80),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CustomButton(
                  onTap: () => Get.to(SettingsScreen()),
                  text: 'Settings',
                ),
              ),
              const Spacer(),
              const Text('Made with ❤️ by Cross Tech'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
