import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../common_files/constants.dart';
import '../../../../../models/worker.dart';
import '../../../../../providers/company_chat_provider.dart';
import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../providers/worker_provider.dart';
import '../../../../../services/responsive.dart';
import '../../../../../services/rounded_image.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../../../old_common_views/worker_timeline/display_worker_timeline_dialog.dart';
import '../../../common_widgets/please_create_company_profile.dart';
import '../../../company_chat/mobile_company_chat/chat_screen.dart';

class WorkerDetailBlockOne extends StatelessWidget {
  final Worker worker;

  const WorkerDetailBlockOne({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context);
    bool isWorkerSaved = up.isWorkerSaved(worker.workerId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: RoundedImageWidget(
                imageUrl: worker.profilePhotoUrl,
                size: Responsive.isMobile(context) ? 40 : 80,
                firstChar:
                    getFirstChar(worker.workerResumeDetails?.lastName ?? ''),
              ),
            ),
            SizedBox(
              width: Responsive.isMobile(context) ? 8 : 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Expanded(
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Flexible(
                          child: Text(
                            "${worker.workerResumeDetails?.firstName ?? '--'} ${worker.workerResumeDetails?.middleName ?? '--'} ${worker.workerResumeDetails?.lastName ?? '--'}",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: Responsive.isMobile(context) ? 16 : 31,
                            ),
                          ),
                        ),
                        if (worker.workStatus == 0)
                          Container(
                            margin:  EdgeInsets.only(left: 10, top: Responsive.isMobile(context) ? 0 : 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: Responsive.isMobile(context) ? 5 : 10,
                                vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(209, 245, 220, 1),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: Responsive.isMobile(context) ? 7 : 10,
                                  color: const Color.fromRGBO(0, 124, 37, 1),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Avalilable",
                                  style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 124, 37, 1),
                                    fontSize:
                                        Responsive.isMobile(context) ? 7 : 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                       ],),
                     ),
                      if (Responsive.isMobile(context))
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context).pop();
                              }
                            },
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor:
                                  ThemeColors.secondaryThemeColorDark,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: Responsive.isMobile(context) ? 13 : 20,
                          color: ThemeColors.secondaryThemeColorDark),
                      const SizedBox(width: 5),
                      Text(
                        worker.location ??
                            AppLocalizations.of(context)!.notSpecified,
                        style: GoogleFonts.montserrat(
                          fontSize: Responsive.isMobile(context) ? 10 : 15,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.black1ThemeColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.isMobile(context) ? 16 : 25),
                  if (Responsive.isDesktop(context))
                    Row(
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 271),
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ThemeColors.secondaryThemeColorDark,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              // Add functionality for Chat
                              if (up.companyTimelineStep < 2) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const DisplayWorkerTimelineDialog());
                              } else {
                                cp.companyStartChat(up.appUser, worker);
                                showDialog(
                                    context: context,
                                    builder: (context) => up
                                            .isUserCompanyProfile()
                                        ? Container(
                                            padding:
                                                Responsive.isDesktop(context)
                                                    ? const EdgeInsets.all(150)
                                                    : const EdgeInsets.all(30),
                                            child:
                                                const CompanyChatRoomScreen())
                                        : const PleaseCreateCompanyProfile());
                              }
                            },
                            child: Center(
                              child: AutoSizeText(
                                "Send Message",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 21),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 271),
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                      color:
                                          ThemeColors.secondaryThemeColorDark)),
                            ),
                            onPressed: () async {
                              if (up.companyTimelineStep < 2) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const DisplayWorkerTimelineDialog());
                              } else {
                                if (!isWorkerSaved) {
                                  up.updateUI(worker.workerId);
                                  wp.addInterestingWorker(up.appUser, worker);
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(isWorkerSaved ? 'Saved' : 'Save',
                                    style: GoogleFonts.montserrat(
                                        color:
                                            ThemeColors.secondaryThemeColorDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                const SizedBox(width: 5),
                                Icon(
                                  isWorkerSaved
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: ThemeColors.secondaryThemeColorDark,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: Responsive.isMobile(context) ? 16 : 30),
        const Divider(
          color: Color.fromRGBO(0, 0, 0, 0.2),
        ),
       
      ],
    );
  }
}
