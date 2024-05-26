import 'package:flutter/material.dart';
import 'package:tictactoe_multiplayer_flutter_app/provider/room_data_provider.dart';
import 'package:tictactoe_multiplayer_flutter_app/screens/create_room_screen.dart';
import 'package:tictactoe_multiplayer_flutter_app/screens/game_screen.dart';
import 'package:tictactoe_multiplayer_flutter_app/screens/join_room_screen.dart';
import 'package:tictactoe_multiplayer_flutter_app/screens/main_menu_screen.dart';
import 'package:tictactoe_multiplayer_flutter_app/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}
