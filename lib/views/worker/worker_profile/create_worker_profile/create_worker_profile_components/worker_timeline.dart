import '../../../../../providers/worker_provider.dart';
import '../../../../../utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:unicons/unicons.dart';

import '../../../../../services/responsive.dart';

const Color highlightColor = ThemeColors.blukersOrangeThemeColor;

const workerSteps = [
  'Classification',
  'Personal Information',
  'Profile Photo',
  'Professional Credentials',
  'Work Experience',
  'References',
  'Resume',
];

const List<Icon> workerIcons = [
  Icon(
    UniconsLine.constructor,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.user,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.user_square,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.award,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.briefcase_alt,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.postcard,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.file_alt,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
];

enum _WorkerStatus { done, doing, todo }

class WorkerTimeLine extends StatelessWidget {
  WorkerTimeLine({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Replace with your data provider
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    var currentStep = wp.workerProfileCurrentPageIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(currentStep * 120.0);
    });

    // return Container(
    //   color: Colors.white,
    //   // margin: const EdgeInsets.all(8),
    //   constraints: const BoxConstraints(maxHeight: 140),
    //   // decoration: BoxDecoration(
    //   //   color: ThemeColors.primaryThemeColor,
    //   //   boxShadow: [
    //   //     BoxShadow(
    //   //       color: Colors.grey,
    //   //       offset: Offset(0.0, 1.0), //(x,y)
    //   //       blurRadius: 6.0,
    //   //     ),
    //   //   ],
    //   //   borderRadius: BorderRadius.circular(10),
    //   //   border: Border.all(
    //   //     color: ThemeColors.secondaryThemeColor,
    //   //     width: 2,
    //   //   ),
    //   // ),
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     controller: _scrollController,
    //     itemCount: workerSteps.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       final step = workerSteps[index];
    //       var indicatorSize = 30.0;
    //       var beforeLineStyle = const LineStyle(
    //         // color: Colors.white.withOpacity(0.8),
    //         color: ThemeColors.secondaryThemeColor,
    //       );
    //       LineStyle afterLineStyle =
    //           const LineStyle(color: ThemeColors.grey1ThemeColor);

    //       _WorkerStatus status;

    //       if (index < currentStep) {
    //         status = _WorkerStatus.done;
    //         afterLineStyle =
    //             const LineStyle(color: ThemeColors.secondaryThemeColor);
    //       } else if (index > currentStep) {
    //         status = _WorkerStatus.todo;
    //         indicatorSize = 20;
    //         beforeLineStyle =
    //             const LineStyle(color: ThemeColors.grey1ThemeColor);
    //       } else {
    //         status = _WorkerStatus.doing;
    //       }

    //       return SizedBox(
    //         width: Responsive.isDesktop(context)
    //             ? MediaQuery.of(context).size.width / 6
    //             : null,
    //         child: TimelineTile(
    //           axis: TimelineAxis.horizontal,
    //           alignment: TimelineAlign.manual,
    //           lineXY: 0.6,
    //           isFirst: index == 0,
    //           isLast: index == workerSteps.length - 1,
    //           beforeLineStyle: beforeLineStyle,
    //           afterLineStyle: afterLineStyle,
    //           indicatorStyle: IndicatorStyle(
    //             width: indicatorSize,
    //             height: indicatorSize,
    //             indicator: _IndicatorWorker(status: status),
    //           ),
    //           startChild: _StartChildWorker(index: index),
    //           endChild: _EndChildWorker(
    //             text: step,
    //             current: index == currentStep,
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );

    List<String> stepsLocalized = [
      AppLocalizations.of(context)!.selectYourIndustriesAndJobs,
      AppLocalizations.of(context)!.personalInformation,
      AppLocalizations.of(context)!.uploadProfilePhoto,
      AppLocalizations.of(context)!.certifications,
      AppLocalizations.of(context)!.workExperience,
      AppLocalizations.of(context)!.personalReferences,
      AppLocalizations.of(context)!.uploadYourResume,
    ];

    return Center(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            // margin: const EdgeInsets.all(8),
            constraints: const BoxConstraints(maxHeight: 140),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: workerSteps.length,
              itemBuilder: (BuildContext context, int index) {
                final step = workerSteps[index];
                var indicatorSize = 30.0;
                var beforeLineStyle = const LineStyle(
                  // color: Colors.white.withOpacity(0.8),
                  color: ThemeColors.secondaryThemeColor,
                );
                LineStyle afterLineStyle =
                    const LineStyle(color: ThemeColors.grey1ThemeColor);

                _WorkerStatus status;

                if (index < currentStep) {
                  status = _WorkerStatus.done;
                  afterLineStyle =
                      const LineStyle(color: ThemeColors.secondaryThemeColor);
                } else if (index > currentStep) {
                  status = _WorkerStatus.todo;
                  indicatorSize = 20;
                  beforeLineStyle =
                      const LineStyle(color: ThemeColors.grey1ThemeColor);
                } else {
                  status = _WorkerStatus.doing;
                }

                return SizedBox(
                  width: Responsive.isDesktop(context)
                      ? MediaQuery.of(context).size.width / 6
                      : null,
                  child: TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    lineXY: 0.6,
                    isFirst: index == 0,
                    isLast: index == workerSteps.length - 1,
                    beforeLineStyle: beforeLineStyle,
                    afterLineStyle: afterLineStyle,
                    indicatorStyle: IndicatorStyle(
                      width: indicatorSize,
                      height: indicatorSize,
                      indicator: _IndicatorWorker(status: status),
                    ),
                    startChild: _StartChildWorker(index: index),
                    endChild: _EndChildWorker(
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

class _StartChildWorker extends StatelessWidget {
  const _StartChildWorker({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(child: workerIcons[index]);
  }
}

class _EndChildWorker extends StatelessWidget {
  const _EndChildWorker({
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
            children: [
              // Flexible(
              //   child: Text(
              //     text,
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w600,
              //       color: current
              //           ? ThemeColors.secondaryThemeColor
              //           : ThemeColors.grey1ThemeColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndicatorWorker extends StatelessWidget {
  const _IndicatorWorker({required this.status});

  final _WorkerStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _WorkerStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.secondaryThemeColor,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Colors.white),
          ),
        );
      case _WorkerStatus.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.secondaryThemeColor,
          ),
          // child: const Center(
          //   child: SizedBox(
          //     height: 15,
          //     width: 15,
          //     // child: CircularProgressIndicator(
          //     //   strokeWidth: 3,
          //     //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          //     // ),
          //   ),
          // ),
        );
      case _WorkerStatus.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.grey1ThemeColor,
          ),
          // child: Center(
          //   child: Container(
          //     width: 10,
          //     height: 10,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Color(0xFF5D6173),
          //     ),
          //   ),
          // ),
        );
    }
    return Container();
  }
}
