import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:unicons/unicons.dart';

import '../../../../providers/user_provider.dart';
import '../../../../utils/styles/index.dart';

const deliverySteps = [
  'Login Information',
  'Basic Information',
  'Contact Information',
];

const List<Icon> icons = [
  Icon(
    UniconsLine.key_skeleton_alt,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.info_circle,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.postcard,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
];

enum _DeliveryStatus { done, doing, todo }

class SignUpTimeline extends StatelessWidget {
  SignUpTimeline({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    var currentStep = up.registerCurrentPageIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(currentStep * 120.0);
    });

    return Container(
      margin: const EdgeInsets.all(8),
      constraints: const BoxConstraints(maxHeight: 140),
      // decoration: BoxDecoration(
      //   color: ThemeColors
      //       .primaryThemeColor, // Set the background color of the container
      //   borderRadius: BorderRadius.circular(20), // Set the border radius
      // ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: deliverySteps.length,
        itemBuilder: (BuildContext context, int index) {
          final step = deliverySteps[index];
          var indicatorSize = 30.0;
          var beforeLineStyle = const LineStyle(
            // color: Colors.white.withOpacity(0.8),
            color: ThemeColors.secondaryThemeColor,
          );
          LineStyle afterLineStyle =
              const LineStyle(color: ThemeColors.grey1ThemeColor);

          _DeliveryStatus status;

          if (index < currentStep) {
            status = _DeliveryStatus.done;
            afterLineStyle =
                const LineStyle(color: ThemeColors.secondaryThemeColor);
          } else if (index > currentStep) {
            status = _DeliveryStatus.todo;
            indicatorSize = 20;
            beforeLineStyle =
                const LineStyle(color: ThemeColors.grey1ThemeColor);
          } else {
            // afterLineStyle = const LineStyle(color: Colors.white);
            status = _DeliveryStatus.doing;
          }

          return TimelineTile(
            axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.manual,
            lineXY: 0.6,
            isFirst: index == 0,
            isLast: index == deliverySteps.length - 1,
            beforeLineStyle: beforeLineStyle,
            afterLineStyle: afterLineStyle,
            indicatorStyle: IndicatorStyle(
              width: indicatorSize,
              height: indicatorSize,
              indicator: _IndicatorDelivery(status: status),
            ),
            startChild: _StartChildDelivery(index: index),
            endChild: _EndChildDelivery(
              text: step,
              current: index == currentStep,
            ),
          );
        },
      ),
    );
  }
}

class _StartChildDelivery extends StatelessWidget {
  const _StartChildDelivery({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Center(child: icons[index]);
  }
}

class _EndChildDelivery extends StatelessWidget {
  const _EndChildDelivery({
    super.key,
    required this.text,
    required this.current,
  });

  final String text;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sniglet(
                    fontSize: 16,
                    color: current
                        ? ThemeColors.secondaryThemeColor
                        : ThemeColors.grey1ThemeColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndicatorDelivery extends StatelessWidget {
  const _IndicatorDelivery({super.key, required this.status});

  final _DeliveryStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _DeliveryStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.secondaryThemeColor,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Colors.white),
          ),
        );
      case _DeliveryStatus.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.secondaryThemeColor,
          ),
          child: const Center(
            child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        );
      case _DeliveryStatus.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.grey1ThemeColor,
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5D6173),
              ),
            ),
          ),
        );
    }
    return Container();
  }
}
