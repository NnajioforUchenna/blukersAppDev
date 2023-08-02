import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../providers/job_posts_provider.dart';
import '../../../../utils/styles/index.dart';

const jobPostSteps = [
  'Classification',
  'Basic Information',
  'Qualification and Skills',
  'Compensation and Contract',
  'Additional Information',
];

const List<Icon> jobPostIcons = [
  Icon(
    Icons.class_,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.info,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.check_box,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.monetization_on,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.note_add,
    color: Colors.white,
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

    return Container(
      margin: const EdgeInsets.all(8),
      constraints: const BoxConstraints(maxHeight: 140),
      decoration: BoxDecoration(
        color: ThemeColors.primaryThemeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: jobPostSteps.length,
        itemBuilder: (BuildContext context, int index) {
          final step = jobPostSteps[index];
          var indicatorSize = 30.0;
          var beforeLineStyle = LineStyle(
            color: Colors.white.withOpacity(0.8),
          );
          LineStyle afterLineStyle = const LineStyle(color: Color(0xFF747888));

          _JobPostStatus status;

          if (index < currentStep) {
            status = _JobPostStatus.done;
            afterLineStyle = const LineStyle(color: Colors.white);
          } else if (index > currentStep) {
            status = _JobPostStatus.todo;
            indicatorSize = 20;
            beforeLineStyle = const LineStyle(color: Color(0xFF747888));
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
    );
  }
}

class _StartChildJobPost extends StatelessWidget {
  const _StartChildJobPost({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Center(child: jobPostIcons[index]);
  }
}

class _EndChildJobPost extends StatelessWidget {
  const _EndChildJobPost({
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
                    fontSize: 14,
                    color: current
                        ? ThemeColors.secondaryThemeColor
                        : Colors.white,
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

class _IndicatorJobPost extends StatelessWidget {
  const _IndicatorJobPost({super.key, required this.status});

  final _JobPostStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _JobPostStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Color(0xFF5D6173)),
          ),
        );
      case _JobPostStatus.doing:
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
      case _JobPostStatus.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF747888),
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
