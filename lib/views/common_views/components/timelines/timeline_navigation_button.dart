import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/utils/helpers/index.dart';
import 'package:unicons/unicons.dart';

class TimelineNavigationButton extends StatelessWidget {
  TimelineNavigationButton({
    super.key,
    required this.isSelected,
    required this.onPress,
    this.navDirection = "right", // "left", "right"
  });

  bool isSelected;
  Function onPress;
  String navDirection;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPress(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          isSelected ? Colors.deepOrangeAccent : Colors.grey,
        ),
      ),
      // child: Text(
      //   AppLocalizations.of(context)!.next,
      //   style: TextStyle(
      //     fontFamily: "Montserrat",
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
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
