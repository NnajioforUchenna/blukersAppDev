import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InfoDisplayListComponent extends StatelessWidget {
  const InfoDisplayListComponent(
      {super.key, required this.placeHolder, required this.value, this.icon});
  final String placeHolder;
  final List<String> value;
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
            if (value.isNotEmpty)
              ...value
                  .map((e) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            // color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blueAccent)),
                        child: Text(
                          e != "" ? e : "Not Available",
                          style: ThemeTextStyles
                              .informationDisplayPlaceHolderThemeTextStyle,
                        ),
                      ))
                  .toList()
            else
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    // color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueAccent)),
                child: const Text(
                  "Not Available",
                  style: ThemeTextStyles
                      .informationDisplayPlaceHolderThemeTextStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
