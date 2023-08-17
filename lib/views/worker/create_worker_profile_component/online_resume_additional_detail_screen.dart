import 'package:blukers/views/worker/create_worker_profile_component/reference_page.dart';
import 'package:blukers/views/worker/create_worker_profile_component/worker_experience_profile.dart';
import 'package:blukers/views/worker/create_worker_profile_component/worker_reference_profile.dart';
import 'package:flutter/material.dart';

class OnlineResumeAdditionalDetailScreen extends StatelessWidget {
  const OnlineResumeAdditionalDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isReference = (ModalRoute.of(context)!.settings.arguments
        as Map<String, bool>)["isReference"] as bool;
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
