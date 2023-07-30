import 'package:bulkers/views/company/workers_components/worker_display_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/worker.dart';

class DisplayWorkerDialog extends StatelessWidget {
  final Worker worker;
  const DisplayWorkerDialog({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              WorkerDisplayWidget(
                worker: worker,
              )
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  child: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
