import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:bulkers/services/responsive.dart';

import '../../../models/worker.dart';
import '../../../providers/worker_provider.dart';
import 'display_worker_dialog.dart';
import 'package:bulkers/views/company/workers_components/worker_display_widget.dart';

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
          iconTheme: IconThemeData(
            color: ThemeColors.primaryThemeColor,
          ),
          elevation: 0,
          title: Text(widget.title + ' (Workers)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColors.primaryThemeColor,
              ),
            )),
      body: buildResponsiveContent(context, workers),
    );
  }

  Widget buildListView(BuildContext context, workers) {
    return ListView.separated(
        padding:
            const EdgeInsets.all(10), // Added to give some space around cards
        itemCount: workers.length,
        itemBuilder: (context, index) {
          final worker = workers[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ThemeColors.primaryThemeColor, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 0), // Adjust for spacing
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15), // Add padding for larger appearance
              onTap: () {
                setState(() {
                  _selectedWorker = worker;
                });
                
                print(
                  'Display details for ${worker.firstName} ${worker.lastName}');
                //
                if (Responsive.isDesktop(context)) {
                  //
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => DisplayWorkerDialog(
                      worker: worker,
                    ));
                }
                //
              },
              title: Text(
                '${worker.firstName} ${worker.lastName}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primaryThemeColor,
                ),
              ),
              subtitle: Text(worker.skillIds.toString()),
              leading: Container(
                width: 50, // Adjust size as necessary
                height: 50, // Adjust size as necessary
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), // Rounded rectangle
                  image: DecorationImage(
                    image: NetworkImage(worker.profilePhotoUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              trailing: Text(worker.workStatus!.toString()),
              // Add more details for each worker, if needed
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 5,
          );
        },
      );
  }

  Widget buildResponsiveContent(BuildContext context, workers) {
    if (Responsive.isDesktop(context)) {
      return buildWebContent(context, workers);
    } else {
      return buildMobileContent(context, workers);
    }
  }

  Widget buildMobileContent(BuildContext context, workers) {
    return buildListView(
      context, 
      workers, 
    );
  }

  Widget buildWebContent(BuildContext context, workers) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1st column
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildListView(
              context, 
              workers, 
            ),
          ),
        ),
        // 2nd column
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                 WorkerDisplayWidget(
                  worker: _selectedWorker == null
                    ? workers[0]
                    : _selectedWorker,
                )
              ],
            ),
          ),
        ),
        // Flexible(
        //   fit: FlexFit.tight,
        //   child: WorkerDisplayWidget(
        //           worker: workers[0],
        //         ),
        // ),
      ],
    );
  }
  //
}
