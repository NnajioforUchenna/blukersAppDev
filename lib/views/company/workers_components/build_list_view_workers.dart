import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/worker.dart';
import '../../../providers/worker_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import 'display_worker_dialog.dart';

class BuildListViewWorkers extends StatelessWidget {
  const BuildListViewWorkers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    final List<Worker> workers = wp.selectedWorkers;
    return ListView.separated(
      padding:
          const EdgeInsets.all(10), // Added to give some space around cards
      itemCount: workers.length,
      itemBuilder: (context, index) {
        final worker = workers[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: ThemeColors.primaryThemeColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 0), // Adjust for spacing
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15), // Add padding for larger appearance
            onTap: () {
              if (Responsive.isDesktop(context)) {
                wp.setSelectedWorker(worker);
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
              style: const TextStyle(
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
}
