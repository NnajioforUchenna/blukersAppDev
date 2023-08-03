import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/worker_provider.dart';
import 'reference_form.dart';

class ReferencePage extends StatelessWidget {
  ReferencePage({Key? key}) : super(key: key);
  List<ReferenceForm> referenceForms = [];

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    for (int i = 0; i < wp.references.length; i++) {
      referenceForms.add(ReferenceForm(index: i));
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...referenceForms,
            Tooltip(
              message: "Add more References",
              child: InkWell(
                onTap: () {
                  wp.addReference();
                },
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        wp.addReference();
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Add more References",
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
