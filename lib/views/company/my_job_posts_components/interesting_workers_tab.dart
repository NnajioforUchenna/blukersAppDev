import 'package:bulkers/models/worker.dart';
import 'package:bulkers/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/worker_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import '../workers_components/display_worker_dialog.dart';
import 'interesting_workers_components/loading_interesting_workers.dart';
import 'interesting_workers_components/no_interesting_worker.dart';

class InterestingWorkersTab extends StatelessWidget {
  const InterestingWorkersTab({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return StreamBuilder<List<Worker>>(
      stream: cp.getInterestingWorkersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingInterestingWorkers();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const NoInterestingWorkers();
        } else {
          List<Worker> workers = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: workers.length,
            itemBuilder: (context, index) {
              Worker worker = workers[index];
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
                    horizontal: 15,
                  ),
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
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage(worker.profilePhotoUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Take up only as much space as needed
                    children: [
                      IconButton(
                        onPressed: () {
                          // Add functionality for Chat
                        },
                        icon: Icon(Icons.chat), // Chat icon
                      ),
                    ],
                  ),
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
      },
    );
  }
}
