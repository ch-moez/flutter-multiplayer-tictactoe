import 'package:flutter/material.dart';
import 'package:tictactoe_multiplayer_flutter_app/resources/socket_methods.dart';
import 'package:tictactoe_multiplayer_flutter_app/responsive/responsive.dart';
import 'package:tictactoe_multiplayer_flutter_app/widgets/custom_button.dart';
import 'package:tictactoe_multiplayer_flutter_app/widgets/custom_text.dart';
import 'package:tictactoe_multiplayer_flutter_app/widgets/custom_textfield.dart';

import '../widgets/socket_is_connected.dart';


class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _socketMethods.errorOccuredListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(),
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.08),
              SocketIsConnected(),
              const CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                text: 'Create Room',
                fontSize: 50,
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your nickname',
              ),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                  onTap: () => _socketMethods.createRoom(
                        _nameController.text,
                      ),
                  text: 'Create'),
            ],
          ),
        ),
      ),
    );
  }
}
