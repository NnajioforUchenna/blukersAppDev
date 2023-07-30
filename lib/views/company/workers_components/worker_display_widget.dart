import 'package:flutter/material.dart';

import '../../../models/worker.dart';
// Replace with your actual path.

class WorkerDisplayWidget extends StatelessWidget {
  final Worker worker;

  const WorkerDisplayWidget({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Picture
          if (worker.profilePhotoUrl != null)
            Image.network(worker.profilePhotoUrl!),
          // Container(
          //     width: 100, // Adjust size as necessary
          //     height: 100, // Adjust size as necessary
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(100), // Rounded rectangle
          //       image: DecorationImage(
          //         image: NetworkImage(worker.profilePhotoUrl!),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          
          const SizedBox(height: 10.0),

          // Full Name
          Text(
            '${worker.firstName} ${worker.middleName ?? ""} ${worker.lastName}',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10.0),

          // Work Status
          Text(
            'Work Status: ${worker.workStatus == WorkStatus.activelyLooking ? 'Actively Looking' : 'Hired'}',
          ),

          const SizedBox(height: 10.0),

          // Skills
          Text('Skills: ${worker.skillIds.join(', ')}'),

          const SizedBox(height: 10.0),

          // Birthdate
          Text('Birthdate: ${worker.birthdate.toLocal().toIso8601String()}'),

          const SizedBox(height: 10.0),

          // Address (Displaying only the first address for simplicity)
          if (worker.addresses != null && worker.addresses!.isNotEmpty)
            Text(
                'Address: ${worker.addresses![0].toString()}'), // Assuming Address has a toString method for display.

          const SizedBox(height: 10.0),

          // Work Experience (Displaying only the first work experience for simplicity)
          if (worker.workExperiences != null &&
              worker.workExperiences!.isNotEmpty)
            Text(
                'Work Experience: ${worker.workExperiences![0].toString()}'), // Assuming WorkExperience has a toString method for display.

          const SizedBox(height: 10.0),

          // References (Displaying only the first reference for simplicity)
          if (worker.references != null && worker.references!.isNotEmpty)
            Text(
                'Reference: ${worker.references![0].toString()}'), // Assuming Reference has a toString method for display.

          // ... Add more fields as required ...
        ],
      ),
    );
  }
}
