import 'package:flutter/material.dart';

import '../../../models/worker.dart';

class ConfirmationDialog extends StatelessWidget {
  final Worker worker;
  const ConfirmationDialog({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'You are adding ${worker.firstName} ${worker.lastName} to the List of your Interesting Workers ?',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Delete worker
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('No'),
                  ),
                ],
              ),
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
