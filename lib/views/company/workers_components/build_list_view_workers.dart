import 'package:bulkers/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/worker.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/worker_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../common_views/please_login_dialog.dart';
import 'confirmation_dialog.dart';
import 'display_worker_dialog.dart';

class BuildListViewWorkers extends StatelessWidget {
  const BuildListViewWorkers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
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
              mainAxisSize:
                  MainAxisSize.min, // Take up only as much space as needed
              children: [
                IconButton(
                  onPressed: () async {
                    // Add functionality for Save
                    if (up.appUser == null) {
                      showDialog(
                          context: context,
                          builder: (context) => PleaseLoginDialog());
                    } else {
                      bool? result = await showDialog<bool>(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          worker: worker,
                        ),
                      );
                      if (result != null && result) {
                        wp.addInterestingWorker(up.appUser, worker);
                      }
                    }
                    ;
                  },
                  icon:
                      Icon(Icons.bookmark), // Assuming this is the 'Save' icon
                ),
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
}
