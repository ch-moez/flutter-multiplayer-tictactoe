import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'provider/room_data_provider.dart';
import 'screens/create_room_screen.dart';
import 'screens/game_screen/game_screen.dart';
import 'screens/join_room_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/room_list.dart';
import 'util/colors.dart';

class AppProvider extends StatelessWidget {
  AppProvider({super.key});

  String platformName = kIsWeb ? 'web' : Platform.operatingSystem;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: GetMaterialApp(
        title: platformName,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.routeName: (context) => MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
          RoomList.routeName: (context) => const RoomList(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}
