import 'package:flutter/material.dart';

class WorkerDetailBlockFive extends StatelessWidget {
  final List<String> skills;

  const WorkerDetailBlockFive({Key? key, required this.skills})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Skills",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: skills
                .map((skill) => Chip(
                      label: Text(skill),
                      backgroundColor: Colors.blue,
                      labelStyle: TextStyle(color: Colors.white),
                    ))
                .toList(),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
