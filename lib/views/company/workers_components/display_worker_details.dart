import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/worker.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../common_views/loading_page.dart';
// Replace with your actual path.

class WorkerDisplayDetailsWidget extends StatelessWidget {
  const WorkerDisplayDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    Worker? worker = wp.selectedWorker;
    return wp.selectedWorker == null
        ? Center(child: SizedBox(height: 100, width: 100, child: LoadingPage()))
        : Container(
            margin: const EdgeInsets.only(right: 50),
            child: Card(
              elevation: 5,
              child: AnimatedContainer(
                height: 1000,
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 2,
                      color: ThemeColors.primaryThemeColor,
                    ),
                  ),
                ),
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      // DetailPageBlockOne(worker: worker),
                      // DetailPageBlockTwo(worker: worker),
                      // DetailPageBlockThree(worker: worker),
                      // DetailPageBlockFour(worker: worker),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
