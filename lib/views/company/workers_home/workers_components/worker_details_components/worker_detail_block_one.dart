import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    double scaleFactor = Responsive.textScaleFactor(context);
    double width = MediaQuery.of(context).size.width;
    UserProvider up = Provider.of<UserProvider>(context);
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context);
    bool isWorkerSaved = up.isWorkerSaved(worker.workerId ?? '');

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RoundedImageWidget(
                imageUrl: worker.profilePhotoUrl,
                size: Responsive.isMobile(context) ? 80 : 100,
                firstChar:
                    getFirstChar(worker.workerResumeDetails?.lastName ?? ''),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  worker.timeAgo ?? '',
                  style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 14.sp : 20),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
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
                    icon: Icon(
                      Icons.bookmark_add,
                      size: 30,
                      color: isWorkerSaved
                          ? ThemeColors.secondaryThemeColor
                          : Colors.grey,
                    ))
              ],
            ),
            Wrap(
              children: [
                Text(
                  worker.workerResumeDetails?.firstName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context) ? 18.sp : 24,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  worker.workerResumeDetails?.middleName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context) ? 18.sp : 24,
                  ),
                ),
                SizedBox(width: Responsive.isMobile(context) ? 2.w : 10),
                Text(
                  worker.workerResumeDetails?.lastName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context) ? 18.sp : 24,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  worker.workStatus == WorkStatus.activelyLooking
                      ? 'Actively Looking'
                      : 'Hired',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker.workerResumeDetails?.skillIds?.join(', ') ?? '',
                        // TODO: Change this to worker?.jobIds?.join(', ') ?? '',
                        style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 17.sp : 24,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        worker.location!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                SizedBox(
                  width: width < Responsive.mobileBreakpoint ? 150 : 200,
                  height: width < Responsive.mobileBreakpoint ? 40 : 70,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.secondaryThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded edges
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12), // Bigger button
                    ),
                    icon: const Icon(
                      Icons.chat,
                      size: 30,
                    ), // Chat icon

                    label: Text(
                      'Chat'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16 * scaleFactor),
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
                            builder: (context) => up.isUserCompanyProfile()
                                ? Container(
                                    padding: Responsive.isDesktop(context)
                                        ? const EdgeInsets.all(150)
                                        : const EdgeInsets.all(30),
                                    child: const CompanyChatRoomScreen())
                                : const PleaseCreateCompanyProfile());
                      }
                    },
                  ),
                )
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
