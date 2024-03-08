import '../../common_vieiws/loading_page.dart';
import 'worker_details_components/worker_detail_block_four.dart';
import 'package:flutter/material.dart';

import '../../../models/worker.dart';
import '../../../utils/styles/theme_colors.dart';

import 'worker_details_components/worker_detail_block_five.dart';
import 'worker_details_components/worker_detail_block_one.dart';
import 'worker_details_components/worker_detail_block_three.dart';
import 'worker_details_components/worker_detail_block_two.dart';
// Replace with your actual path.

class WorkerDisplayDetailsWidget extends StatefulWidget {
  final Worker worker;
  const WorkerDisplayDetailsWidget({
    super.key,
    required this.worker,
  });

  @override
  State<WorkerDisplayDetailsWidget> createState() =>
      _WorkerDisplayDetailsWidgetState();
}

class _WorkerDisplayDetailsWidgetState extends State<WorkerDisplayDetailsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = CurvedAnimation(
        parent: _controller, curve: Curves.easeInOut); // Add a curve
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant WorkerDisplayDetailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.worker != widget.worker) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Worker? worker = widget.worker;
    return worker == null
        ? const Center(
            child: SizedBox(height: 100, width: 100, child: LoadingPage()))
        : Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Card(
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 2,
                      color: ThemeColors.primaryThemeColor,
                    ),
                  ),
                ),
                child: FadeTransition(
                  opacity: _animation,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WorkerDetailBlockOne(worker: worker),
                        WorkerDetailBlockTwo(worker: worker),
                        WorkerDetailBlockThree(worker: worker),
                        WorkerDetailBlockFour(
                          workExperiences: worker.workExperiences,
                        ),
                        WorkerDetailBlockFive(
                          skills: worker.skillIds,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
