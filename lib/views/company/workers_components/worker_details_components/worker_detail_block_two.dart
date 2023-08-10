import 'package:bulkers/services/blur_out.dart';
import 'package:flutter/material.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/worker.dart';
import '../../../../services/responsive.dart';

class WorkerDetailBlockTwo extends StatelessWidget {
  final Worker worker;

  const WorkerDetailBlockTwo({Key? key, required this.worker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scaleFactor = Responsive.textScaleFactor(context);
    bool isBlur = true; // You can change this value based on your requirements

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
        children: [
          Row(
            children: [
              Text("Personal Information",
                  style: TextStyle(
                      fontSize: 20 * scaleFactor, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                "Email: ",
                style: TextStyle(fontSize: 18 * scaleFactor),
              ),
              BlurOut(
                isBlur: isBlur,
                child: Text(
                  worker.emails.isNotEmpty
                      ? worker.emails.first
                      : 'Email Not Provided',
                  style: TextStyle(
                    fontSize: 18 * scaleFactor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Text(
                "Phone Number: ",
                style: TextStyle(fontSize: 18),
              ),
              BlurOut(
                isBlur: isBlur,
                child: Text(
                  worker.phoneNumber ?? 'Phone Number Not Provided',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Text(
                "Address: ",
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: BlurOut(
                  isBlur: isBlur,
                  child: Text(
                    getAddressesInStringFormat(worker.addresses),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Spacer(),
              if (isBlur) // If the member is not active, show the "Activate Your Membership" button
                ElevatedButton(
                  onPressed: () {
                    // Handle membership activation
                  },
                  child: Text(
                    "Activate Your Membership",
                    style: TextStyle(fontSize: 16 * scaleFactor),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
