import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:unicons/unicons.dart';

import '../../../../../utils/styles/index.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/responsive.dart';

const Color highlightColor = ThemeColors.blukersOrangeThemeColor;

const deliverySteps = [
  'Login Information',
  'Basic Information',
  'Contact Information',
];

const List<Icon> icons = [
  Icon(
    UniconsLine.key_skeleton_alt,
    color: highlightColor,
    size: 30,
  ),
  Icon(
    UniconsLine.info_circle,
    color: highlightColor,
    size: 30,
  ),
  Icon(
    UniconsLine.postcard,
    color: highlightColor,
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

    List<String> stepsLocalized = [
      AppLocalizations.of(context)!.createYourAccount,
      AppLocalizations.of(context)!.basicInformation,
      AppLocalizations.of(context)!.selectjobspreference,
    ];

    return Center(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            // margin: const EdgeInsets.all(8),
            constraints: BoxConstraints(
                maxHeight: 140,
                maxWidth: MediaQuery.of(context).size.width * 1),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: deliverySteps.length,
              itemBuilder: (BuildContext context, int index) {
                final step = stepsLocalized[index];
                var indicatorSize = 30.0;
                var beforeLineStyle = const LineStyle(
                  // color: Colors.white.withOpacity(0.8),
                  color: highlightColor,
                );
                LineStyle afterLineStyle =
                    const LineStyle(color: ThemeColors.grey1ThemeColor);

                _DeliveryStatus status;

                if (index < currentStep) {
                  status = _DeliveryStatus.done;
                  afterLineStyle = const LineStyle(color: highlightColor);
                } else if (index > currentStep) {
                  status = _DeliveryStatus.todo;
                  indicatorSize = 20;
                  beforeLineStyle =
                      const LineStyle(color: ThemeColors.grey1ThemeColor);
                } else {
                  // afterLineStyle = const LineStyle(color: Colors.white);
                  status = _DeliveryStatus.doing;
                }

                return SizedBox(
                  width: Responsive.isDesktop(context)
                      ? MediaQuery.of(context).size.width / 4
                      : null,
                  child: TimelineTile(
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
                  ),
                );
              },
            ),
          ),
          if (currentStep < stepsLocalized.length)
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 15),
              constraints: BoxConstraints(
                  maxHeight: 140,
                  maxWidth: MediaQuery.of(context).size.width * 1),
              child: Text(
                textAlign: TextAlign.center,
                stepsLocalized[currentStep],
                style: const TextStyle(
                  // color: ThemeColors.grey1ThemeColor,
                  color: ThemeColors.blukersBlueThemeColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StartChildDelivery extends StatelessWidget {
  const _StartChildDelivery({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(child: icons[index]);
  }
}

class _EndChildDelivery extends StatelessWidget {
  const _EndChildDelivery({
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}

class _IndicatorDelivery extends StatelessWidget {
  const _IndicatorDelivery({required this.status});

  final _DeliveryStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _DeliveryStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: highlightColor,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Colors.white),
          ),
        );
      case _DeliveryStatus.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: highlightColor,
          ),
        );
      case _DeliveryStatus.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.grey1ThemeColor,
          ),
        );
    }
    return Container();
  }
}
