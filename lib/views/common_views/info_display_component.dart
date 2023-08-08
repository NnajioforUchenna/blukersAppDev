import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:flutter/material.dart';

class InfoDisplayComponent extends StatelessWidget {
  const InfoDisplayComponent(
      {super.key, required this.placeHolder, required this.value, this.icon});
  final String placeHolder;
  final String value;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    placeHolder,
                    style: ThemeTextStyles
                        .informationDisplayPlaceHolderThemeTextStyle,
                  ),
                ),
                if (icon != null) icon!,
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  // color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blueAccent)),
              child: Text(
                value != ""  ? value : "Not Available",
                style:
                    ThemeTextStyles.informationDisplayPlaceHolderThemeTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
