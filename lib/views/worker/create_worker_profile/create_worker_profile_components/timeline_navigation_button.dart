import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return MaterialButton(
      onPressed: () => onPress(),
      elevation: 0,
      color: navDirection.toString().toLowerCase() == "left" || navDirection.toString().toLowerCase() == "back" ?
           const Color.fromARGB(172, 211, 235, 255)
          : isSelected ? ThemeColors.primaryThemeColor : ThemeColors.primaryThemeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          if (navDirection.toString().toLowerCase() == "right")
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                "Next",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          SvgPicture.asset(
            navDirection.toString().toLowerCase() == "right"
                ? "assets/icons/arrow_next.svg"
                : "assets/icons/arrow_back.svg",
            height: 20,
            width: 20,
          ),
          if (navDirection.toString().toLowerCase() == "left" || navDirection.toString().toLowerCase() == "back")
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Back",
                  style: TextStyle(
                    color: ThemeColors.primaryThemeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
            ),
        ],
      ),
    );
  }
}
