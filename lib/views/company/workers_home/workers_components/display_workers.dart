import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/worker_provider.dart';
import '../../../../services/responsive.dart';
import '../../../../utils/styles/index.dart';
import '../../../common_vieiws/loading_page.dart';
import 'Worker_search_bar.dart';
import 'animate_worker_details_page.dart';
import 'build_list_view_workers.dart';

class DisplayWorkers extends StatefulWidget {
  final String title;

  const DisplayWorkers({super.key, required this.title});

  @override
  State<DisplayWorkers> createState() => _DisplayWorkersState();
}

class _DisplayWorkersState extends State<DisplayWorkers> {
  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ThemeColors.primaryThemeColor,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          title: Text(
            '${widget.title} (Workers)',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 5)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return wp.selectedWorkers.isEmpty
                ? Center(
                    child: Text(
                    AppLocalizations.of(context)!.noworkersfound,
                    style: const TextStyle(
                        color: ThemeColors.blukersOrangeThemeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))
                : Responsive.isDesktop(context)
                    ? buildWebContent()
                    : const BuildListViewWorkers();
          }
        },
      ),
    );
  }

  Widget buildWebContent() {
    return const Column(
      children: [
        WorkerSearchBar(),
        SizedBox(height: 10),
        Expanded(
          child: Row(
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
                  child: AnimateWorkerDetails(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
//
}
