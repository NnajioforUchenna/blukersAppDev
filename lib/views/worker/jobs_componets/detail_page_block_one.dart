import 'package:flutter/material.dart';

import '../../../common_files/constants.dart';
import '../../../models/job_post.dart';
import '../../../utils/styles/theme_colors.dart';

class DetailPageBlockOne extends StatelessWidget {
  final JobPost jobPost;

  const DetailPageBlockOne({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(jobPost.timeAgo ?? ''),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Text(jobPost.jobTitle ?? '',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              jobPost.salaryAmount.toString(),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(width: 5),
            Text(
              getSalaryType(jobPost.salaryType) ?? '',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Text(
              getAddressesInStringFormat(jobPost.addresses),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      ThemeColors.secondaryThemeColor, // <-- Button Color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 36, vertical: 24), // <-- Bigger button
                  elevation: 8, // <-- Elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => null,
                child: Text("Apply".toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20) // <-- Bigger font
                    )),
            Spacer(),
            Image.network(
              jobPost.companyLogo ?? 'https://picsum.photos/200/300',
              height: 100,
              width: 100,
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
