import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../utils/styles/theme_colors.dart';

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
    Icons.class_,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.person,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.photo_camera,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.build,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.work,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.book,
    color: Colors.white,
    size: 30,
  ),
  Icon(
    Icons.description,
    color: Colors.white,
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
        itemCount: workerSteps.length,
        itemBuilder: (BuildContext context, int index) {
          final step = workerSteps[index];
          var indicatorSize = 30.0;
          var beforeLineStyle = LineStyle(
            color: Colors.white.withOpacity(0.8),
          );
          LineStyle afterLineStyle = const LineStyle(color: Color(0xFF747888));

          _WorkerStatus status;

          if (index < currentStep) {
            status = _WorkerStatus.done;
            afterLineStyle = const LineStyle(color: Colors.white);
          } else if (index > currentStep) {
            status = _WorkerStatus.todo;
            indicatorSize = 20;
            beforeLineStyle = const LineStyle(color: Color(0xFF747888));
          } else {
            status = _WorkerStatus.doing;
          }

          return TimelineTile(
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
          );
        },
      ),
    );
  }
}

class _StartChildWorker extends StatelessWidget {
  const _StartChildWorker({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Center(child: workerIcons[index]);
  }
}

class _EndChildWorker extends StatelessWidget {
  const _EndChildWorker({
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

class _IndicatorWorker extends StatelessWidget {
  const _IndicatorWorker({super.key, required this.status});

  final _WorkerStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _WorkerStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Color(0xFF5D6173)),
          ),
        );
      case _WorkerStatus.doing:
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
      case _WorkerStatus.todo:
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
