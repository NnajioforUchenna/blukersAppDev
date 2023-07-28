import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/worker.dart';
import '../../../providers/worker_provider.dart';
import 'display_worker_dialog.dart';

class DisplayWorkers extends StatelessWidget {
  final String title;
  const DisplayWorkers({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    final List<Worker> workers = wp.selectedWorkers;
    return Scaffold(
      appBar: AppBar(
          title: Text('Workers listed under $title',
              textAlign: TextAlign.center,
              style: GoogleFonts.ebGaramond(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ))),
      body: ListView.separated(
        padding:
            const EdgeInsets.all(10), // Added to give some space around cards
        itemCount: workers.length,
        itemBuilder: (context, index) {
          final worker = workers[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 0), // Adjust for spacing
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15), // Add padding for larger appearance
              onTap: () {
                print(
                    'Display details for ${worker.firstName} ${worker.lastName}');
                showDialog(
                    context: context,
                    builder: (context) => DisplayWorkerDialog(
                          worker: worker,
                        ));
              },
              title: Text('${worker.firstName} ${worker.lastName}'),
              subtitle: Text(worker.skillIds.toString()),
              leading: Container(
                width: 50, // Adjust size as necessary
                height: 50, // Adjust size as necessary
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), // Rounded rectangle
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
            height: 10,
          );
        },
      ),
    );
  }
}
