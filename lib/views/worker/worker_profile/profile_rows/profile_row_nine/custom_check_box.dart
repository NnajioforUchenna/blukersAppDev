import 'package:flutter/material.dart';

import '../../../../../utils/styles/theme_colors.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;

  const CustomCheckbox({super.key, required this.value});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 15,
        height: 15,
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: ThemeColors.grey2ThemeColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
          // color: _value ? ThemeColors.secondaryThemeColor : Colors.white,
        ),
        child: Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color:
                widget.value ? ThemeColors.secondaryThemeColor : Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ));
  }
}
