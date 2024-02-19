import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  // BuildContext context;
  String buttonText;
  // Function onPress;
  late Widget widget;

  MenuButton({
    Key? key,
    // required this.context,
    this.buttonText = "CLICK HERE",
    // required this.onPress,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        // onPress();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => widget),
        )
      },
      style: ElevatedButton.styleFrom(
        // minimumSize: const Size.fromHeight(50), // NEW
        foregroundColor: Colors.white, backgroundColor: Colors.blue.shade900,
        shadowColor: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        minimumSize: const Size(300, 50), //////// HERE
      ),
      child: Text(buttonText),
    );
  }
}
