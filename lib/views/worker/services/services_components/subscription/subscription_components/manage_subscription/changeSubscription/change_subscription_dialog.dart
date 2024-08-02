import 'package:flutter/material.dart';

import '../../../../../../../../services/responsive.dart';
import '../../mobile_view/mobile_view_components/color_small_pop_button_widget.dart';
import 'change_subscription.dart';

class ChangeSubscriptionDialog extends StatelessWidget {
  const ChangeSubscriptionDialog({super.key});

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
          EdgeInsets.only(left: 16, right: 16, top: height * 0.20, bottom: 150),
      child: SizedBox(
        width: isDesktop ? MediaQuery.of(context).size.width * 0.5 : null,
        height: height * 0.95,
        child: const Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            ChangeSubscription(),
            Positioned(
              top: 10, // Adjust as needed
              left: 10, // Adjust as needed
              child: ColorSmallPopButtonWidget(
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
