import 'package:blukers/views/worker/create_worker_profile_component/worker_experience_profile.dart';
import 'package:blukers/views/worker/create_worker_profile_component/worker_reference_profile.dart';
import 'package:flutter/material.dart';

class OnlineResumeAdditionalDetailScreen extends StatelessWidget {
  final bool isReference;
  const OnlineResumeAdditionalDetailScreen(
      {super.key, required this.isReference});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: (isReference)
            ? WorkerReferenceProfile()
            : WorkerExperienceProfile(),
      ),
    );
  }
}
