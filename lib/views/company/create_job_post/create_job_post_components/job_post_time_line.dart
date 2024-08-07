import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:unicons/unicons.dart';

import '../../../../providers/job_posts_provider.dart';
import '../../../../utils/styles/index.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color highlightColor = ThemeColors.blukersOrangeThemeColor;

const jobPostSteps = [
  'Classification',
  'Basic Information',
  'Qualification and Skills',
  'Compensation and Contract',
  'Additional Information',
];

const List<Icon> jobPostIcons = [
  Icon(
    UniconsLine.hard_hat,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.exclamation_circle,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.trophy,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.usd_square,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.plus_square,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
];

enum _JobPostStatus { done, doing, todo }

class JobPostTimeline extends StatelessWidget {
  JobPostTimeline({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    var currentStep = jp.jobPostCurrentPageIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(currentStep * 120.0);
    });

    // return Container(
    //   color: Colors.white,
    //   // margin: const EdgeInsets.all(8),
    //   constraints: const BoxConstraints(maxHeight: 140),
    //   // decoration: BoxDecoration(
    //   //   color: ThemeColors.primaryThemeColor,
    //   //   borderRadius: BorderRadius.circular(20),
    //   // ),
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     controller: _scrollController,
    //     itemCount: jobPostSteps.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       final step = jobPostSteps[index];
    //       var indicatorSize = 30.0;
    //       var beforeLineStyle = const LineStyle(
    //         // color: Colors.white.withOpacity(0.8),
    //         color: ThemeColors.secondaryThemeColor,
    //       );
    //       LineStyle afterLineStyle =
    //           const LineStyle(color: ThemeColors.grey1ThemeColor);

    //       _JobPostStatus status;

    //       if (index < currentStep) {
    //         status = _JobPostStatus.done;
    //         afterLineStyle =
    //             const LineStyle(color: ThemeColors.secondaryThemeColor);
    //       } else if (index > currentStep) {
    //         status = _JobPostStatus.todo;
    //         indicatorSize = 20;
    //         beforeLineStyle =
    //             const LineStyle(color: ThemeColors.grey1ThemeColor);
    //       } else {
    //         status = _JobPostStatus.doing;
    //       }

    //       return TimelineTile(
    //         axis: TimelineAxis.horizontal,
    //         alignment: TimelineAlign.manual,
    //         lineXY: 0.6,
    //         isFirst: index == 0,
    //         isLast: index == jobPostSteps.length - 1,
    //         beforeLineStyle: beforeLineStyle,
    //         afterLineStyle: afterLineStyle,
    //         indicatorStyle: IndicatorStyle(
    //           width: indicatorSize,
    //           height: indicatorSize,
    //           indicator: _IndicatorJobPost(status: status),
    //         ),
    //         startChild: _StartChildJobPost(index: index),
    //         endChild: _EndChildJobPost(
    //           text: step,
    //           current: index == currentStep,
    //         ),
    //       );
    //     },
    //   ),
    // );

    List<String> stepsLocalized = [
      AppLocalizations.of(context)!.selectAnIndustryAndAJobPosition,
      AppLocalizations.of(context)!.jobDetails,
      AppLocalizations.of(context)!.requirementsAndSkills,
      AppLocalizations.of(context)!.compensationAndContract,
      AppLocalizations.of(context)!.jobLocation,
    ];

    return Column(
      children: [
        Container(
          color: Colors.white,
          // margin: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxHeight: 140),
          // decoration: BoxDecoration(
          //   color: ThemeColors.primaryThemeColor,
          //   borderRadius: BorderRadius.circular(20),
          // ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: jobPostSteps.length,
            itemBuilder: (BuildContext context, int index) {
              final step = jobPostSteps[index];
              var indicatorSize = 30.0;
              var beforeLineStyle = const LineStyle(
                // color: Colors.white.withOpacity(0.8),
                color: ThemeColors.secondaryThemeColor,
              );
              LineStyle afterLineStyle =
                  const LineStyle(color: ThemeColors.grey1ThemeColor);

              _JobPostStatus status;

              if (index < currentStep) {
                status = _JobPostStatus.done;
                afterLineStyle =
                    const LineStyle(color: ThemeColors.secondaryThemeColor);
              } else if (index > currentStep) {
                status = _JobPostStatus.todo;
                indicatorSize = 20;
                beforeLineStyle =
                    const LineStyle(color: ThemeColors.grey1ThemeColor);
              } else {
                status = _JobPostStatus.doing;
              }

              return TimelineTile(
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.manual,
                lineXY: 0.6,
                isFirst: index == 0,
                isLast: index == jobPostSteps.length - 1,
                beforeLineStyle: beforeLineStyle,
                afterLineStyle: afterLineStyle,
                indicatorStyle: IndicatorStyle(
                  width: indicatorSize,
                  height: indicatorSize,
                  indicator: _IndicatorJobPost(status: status),
                ),
                startChild: _StartChildJobPost(index: index),
                endChild: _EndChildJobPost(
                  text: step,
                  current: index == currentStep,
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
    );
  }
}

class _StartChildJobPost extends StatelessWidget {
  const _StartChildJobPost({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Center(child: jobPostIcons[index]);
  }
}

class _EndChildJobPost extends StatelessWidget {
  const _EndChildJobPost({
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
              //     style: GoogleFonts.sniglet(
              //       fontSize: 14,
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

class _IndicatorJobPost extends StatelessWidget {
  const _IndicatorJobPost({required this.status});

  final _JobPostStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _JobPostStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.secondaryThemeColor,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Colors.white),
          ),
        );
      case _JobPostStatus.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.secondaryThemeColor,
          ),
          // child: const Center(
          //   child: SizedBox(
          //     height: 15,
          //     width: 15,
          //     child: CircularProgressIndicator(
          //       strokeWidth: 3,
          //       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          //     ),
          //   ),
          // ),
        );
      case _JobPostStatus.todo:
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
