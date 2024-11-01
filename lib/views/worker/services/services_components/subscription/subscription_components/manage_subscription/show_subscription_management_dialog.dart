import 'package:flutter/material.dart';

import '../mobile_view/mobile_view_components/color_small_pop_button_widget.dart';
import 'subscription_management_widget.dart';

class ShowSubscriptionManagementDialog extends StatelessWidget {
  const ShowSubscriptionManagementDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      insetPadding:
          EdgeInsets.only(left: 16, right: 16, top: height * 0.13, bottom: 100),
      child: SizedBox(
        width: width * 0.95,
        height: height * 0.95,
        child: const Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SubscriptionManagement(),
            Positioned(
              top: 10, // Adjust as needed
              left: 10, // Adjust as needed
              child: ColorSmallPopButtonWidget(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
