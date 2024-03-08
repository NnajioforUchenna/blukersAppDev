import '../worker_experience_profile.dart';
import '../reference/worker_reference_profile.dart';
import 'package:flutter/material.dart';

class OnlineResumeAdditionalDetailScreen extends StatelessWidget {
  final bool isReference;

  const OnlineResumeAdditionalDetailScreen(
      {super.key, required this.isReference});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: (isReference)
            ? const WorkerReferenceProfile()
            : const WorkerExperienceProfile(),
      ),
    );
  }
}
