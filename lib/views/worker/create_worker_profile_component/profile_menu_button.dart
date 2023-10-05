import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:blukers/utils/styles/index.dart';

class ProfileMenuButton extends StatelessWidget {
  String text;
  Function onPress;
  Color textColor;

  ProfileMenuButton({
    required this.text,
    required this.onPress,
    this.textColor = ThemeColors.grey1ThemeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        // margin: const EdgeInsets.all(14.0),
        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the container
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25), // Box shadow color
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                UniconsLine.angle_right,
                size: 30.0,
                color: ThemeColors.grey2ThemeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
