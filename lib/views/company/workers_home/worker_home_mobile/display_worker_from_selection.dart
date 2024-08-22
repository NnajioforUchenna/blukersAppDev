import 'package:blukers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../display_workers/display_workers.dart';

class DisplayWorkerFromSelection extends StatelessWidget {
  final String title;
  const DisplayWorkerFromSelection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const DisplayWorkers(),
    );
  }
}
