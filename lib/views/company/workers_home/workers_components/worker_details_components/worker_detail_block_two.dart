import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common_files/constants.dart';
import '../../../../../models/worker.dart';
import '../../../../../services/blur_out.dart';
import '../../../../../services/responsive.dart';

class WorkerDetailBlockTwo extends StatelessWidget {
  final Worker worker;

  const WorkerDetailBlockTwo({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    double scaleFactor = Responsive.textScaleFactor(context);
    bool isBlur = true; // You can change this value based on your requirements

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
        children: [
          Text("Personal Information",
              style: TextStyle(
                  fontSize: 20 * scaleFactor, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                "Email: ",
                style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 12.sp : 18),
              ),
              Flexible(
                child: BlurOut(
                  isBlur: isBlur,
                  child: Text(
                    worker.emails.isNotEmpty
                        ? worker.emails.first
                        : 'Email Not Provided',
                    style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 12.sp : 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                "Phone Number: ",
                style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 12.sp : 18),
              ),
              Flexible(
                child: BlurOut(
                  isBlur: isBlur,
                  child: Text(
                    worker.phoneNumber ?? 'Phone Number Not Provided',
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 12.sp : 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                "Address: ",
                style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 12.sp : 18),
              ),
              Flexible(
                child: BlurOut(
                  isBlur: isBlur,
                  child: Text(
                    getAddressesInStringFormat(worker.address),
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 12.sp : 18),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Spacer(),
              if (isBlur) // If the member is not active, show the "Activate Your Membership" button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w, vertical: 3.h), // Custom padding
                  ),
                  child: Text(
                    "Activate Your Membership",
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 10.sp : 16),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
