import 'package:bulkers/services/responsive.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:bulkers/views/common_views/loading_page.dart';
import 'package:bulkers/views/company/workers_components/build_list_view_workers.dart';
import 'package:bulkers/views/company/workers_components/worker_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/worker.dart';
import '../../../providers/worker_provider.dart';

class DisplayWorkers extends StatefulWidget {
  final String title;
  DisplayWorkers({super.key, required this.title});

  @override
  State<DisplayWorkers> createState() => _DisplayWorkersState();
}

class _DisplayWorkersState extends State<DisplayWorkers> {
  Worker? _selectedWorker;

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    final List<Worker> workers = wp.selectedWorkers;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: ThemeColors.primaryThemeColor,
          ),
          elevation: 0,
          title: Text(
            '${widget.title} (Workers)',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeColors.primaryThemeColor,
            ),
          )),
      body: wp.selectedWorkers.isEmpty
          ? LoadingPage()
          : Responsive.isDesktop(context)
              ? buildWebContent()
              : const BuildListViewWorkers(),
    );
  }

  Widget buildWebContent() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1st column
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: BuildListViewWorkers(),
          ),
        ),
        // 2nd column
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: WorkerDisplayWidget(),
          ),
        ),
      ],
    );
  }
  //
}
