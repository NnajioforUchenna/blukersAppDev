import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Timeline extends StatelessWidget {
  final int currentStep;
  const Timeline({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TimeLineWidget(
          showBorder: currentStep >= 0,
          showCheckMark: currentStep >= 1,
          icon: "assets/icons/email.svg",
        ),
        const Expanded(
          child: Divider(
            color: Color.fromRGBO(217, 217, 217, 1),
            height: 2,
          ),
        ),
        TimeLineWidget(
          showBorder: currentStep == 1 || currentStep == 2,
          showCheckMark: currentStep == 2,
          icon: "assets/icons/info.svg",
        ),
        const Expanded(
          child: Divider(
            color: Color.fromRGBO(217, 217, 217, 1),
            height: 2,
          ),
        ),
        TimeLineWidget(
          showBorder: currentStep == 2,
          showCheckMark: false,
          icon: "assets/icons/box.svg",
        ),
      ],
    );
  }
}

class TimeLineWidget extends StatelessWidget {
  final bool showBorder;
  final bool showCheckMark;
  final String icon;
  const TimeLineWidget(
      {super.key,
      required this.showBorder,
      required this.showCheckMark,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 36,
          width: 36,
          alignment: Alignment.center,
          decoration: showBorder
              ? BoxDecoration(
                  color: const Color.fromRGBO(27, 117, 187, 0.1),
                  borderRadius: BorderRadius.circular(5.0),
                )
              : null,
          child: SvgPicture.asset(
            icon,
          ),
        ),
        if (showCheckMark)
          Positioned(
              right: 0, child: SvgPicture.asset("assets/icons/checkmark.svg")),
      ],
    );
  }
}
