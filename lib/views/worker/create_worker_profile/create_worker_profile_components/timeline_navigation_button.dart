import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class TimelineNavigationButton extends StatelessWidget {
  TimelineNavigationButton({
    super.key,
    required this.isSelected,
    required this.onPress,
    this.navDirection = "right",
  });

  bool isSelected;
  Function onPress;
  String navDirection;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPress(),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          isSelected ? Colors.deepOrangeAccent : Colors.grey,
        ),
      ),
      child: Icon(
        navDirection.toString().toLowerCase() == "right"
            ? UniconsLine.arrow_right
            : UniconsLine.arrow_left,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
