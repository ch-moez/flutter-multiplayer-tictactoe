import 'package:flutter/material.dart';



class GameButton extends StatelessWidget {
  GameButton(
      {super.key,
      required this.onTap,
      this.color = Colors.blue,
      this.secondaryColor,
      required this.label,
      this.icon});
  final Function onTap;
  final Color color;
  final String label;
  Color? secondaryColor = Colors.blue[300];
  Icon? icon;

  double buttonWidth = 600;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Stack(children: [
          Container(
            height: 100,
            width: buttonWidth,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black45,
                      spreadRadius: 0.5,
                      offset: Offset(3, 4))
                ]),
          ),
          Container(
            height: 90,
            width: buttonWidth,
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black12,
                      spreadRadius: 0.3,
                      offset: Offset(
                        5,
                        3,
                      ))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  label,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        const Shadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(1, 2),
                        ),
                        Shadow(
                            color: color,
                            blurRadius: 2,
                            offset: const Offset(0.5, 2))
                      ]),
                )),
                icon ??
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Icon(Icons.settings, color: Colors.white)],
                    )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
