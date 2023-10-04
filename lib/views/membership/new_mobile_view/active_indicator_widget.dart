import 'package:flutter/material.dart';

class ActiveIndicatorWidget extends StatelessWidget {
  final bool isActive;
  const ActiveIndicatorWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        width: 24, // Adjust as needed
        height: 24, // Adjust as needed
        decoration: const BoxDecoration(
          color: Colors.white, // Adjust as needed
          shape: BoxShape.circle,
        ),
        child: Center(
            child: isActive
                ? Container(
                    width: 17, // Adjust as needed
                    height: 17, // Adjust as needed
                    decoration: const BoxDecoration(
                      color: Colors.green, // Adjust as needed
                      shape: BoxShape.circle,
                    ),
                  )
                : Container()),
      ),
    );
  }
}
