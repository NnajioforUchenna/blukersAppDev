import '../../../../models/job_post.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ApplyButtonWidget extends StatelessWidget {
  final JobPost jobPost;
  const ApplyButtonWidget({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    bool isJobApplied = !up.isJobPostApplied(jobPost.jobPostId ?? '');
    return InkWell(
      onTap: isJobApplied
          ? () {
        up.checkAndApplyJobPost(context, jobPost);
      }
          : null,
      child: Container(
        height: 50.0,
        decoration:  BoxDecoration(
          color: isJobApplied
              ? ThemeColors.blukersBlueThemeColor
              : Colors.grey, // Example background color
          borderRadius: const BorderRadius.all(
            Radius.circular(50.0), // Adjust the radius as needed
          ),
        ),

        child: Center(
          // Center the text inside the button
          child: Text(
            isJobApplied
                ? AppLocalizations.of(context)!.apply.toUpperCase()
                : AppLocalizations.of(context)!.alreadyApplied,
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
        ),
        // child: Row(
        //   children: [
        //     const Spacer(),
        //     SizedBox(
        //         width: 200,
        //         child: ElevatedButton(
        //           onPressed: isJobApplied
        //               ? () {
        //                   up.checkAndApplyJobPost(context, jobPost);
        //                 }
        //               : null,
        //           style: ElevatedButton.styleFrom(
        //             padding: const EdgeInsets.symmetric(vertical: 10),
        //             textStyle: const TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.w600,
        //             ),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(
        //                   30.0), // Adjust the radius as needed
        //             ),
        //           ),
        //           child: Center(
        //             // Center the text inside the button
        //             child: Text(
        //               isJobApplied
        //                   ? AppLocalizations.of(context)!.apply.toUpperCase()
        //                   : AppLocalizations.of(context)!.alreadyApplied,
        //               style: GoogleFonts.montserrat(color: Colors.white),
        //             ),
        //           ),
        //         )),
        //     const Spacer(),
        //   ],
        // ),
      ),
    );
  }
}
