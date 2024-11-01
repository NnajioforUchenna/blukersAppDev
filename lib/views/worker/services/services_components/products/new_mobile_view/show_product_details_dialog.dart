import 'package:flutter/material.dart';

import '../../../../../../services/responsive.dart';
import '../../subscription/subscription_components/mobile_view/mobile_view_components/color_small_pop_button_widget.dart';

class ShowProductDetailsDialog extends StatelessWidget {
  final Widget membership;
  final Color color;
  const ShowProductDetailsDialog(
      {super.key, required this.membership, required this.color});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Adjusted logic to use context if Responsive requires it
    bool isDesktop = Responsive.isDesktop(context);

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      insetPadding:
          EdgeInsets.only(left: 16, right: 16, top: height * 0.13, bottom: 100),
      child: SizedBox(
        width: isDesktop ? width * 0.5 : width * 0.95,
        height: height * 0.95,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            membership,
            Positioned(
              top: 10, // Adjust as needed
              left: 10, // Adjust as needed
              child: ColorSmallPopButtonWidget(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
