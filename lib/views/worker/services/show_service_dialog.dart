import 'package:flutter/material.dart';

import '../../common_views/small_pop_button_widget.dart';

class ShowServiceDialog extends StatelessWidget {
  final Widget service;
  const ShowServiceDialog({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding:
          const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 80),
      child: SizedBox(
        width: width * 0.95,
        height: height * 0.95,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            service,
            const Positioned(
              top: 10, // Adjust as needed
              left: 10, // Adjust as needed
              child: SmallPopButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
