import 'package:blukers/models/worker.dart';
import 'package:blukers/providers/chat_provider.dart';
import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/services/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../common_files/constants.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/responsive.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../common_views/worker_timeline/display_worker_timeline_dialog.dart';

class WorkerDetailBlockOne extends StatelessWidget {
  final Worker worker;
  const WorkerDetailBlockOne({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    double scaleFactor = Responsive.textScaleFactor(context);
    double width = MediaQuery.of(context).size.width;
    UserProvider up = Provider.of<UserProvider>(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
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
                firstChar: getFirstChar(worker.lastName ?? ''),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(worker.timeAgo ?? ''),
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
            Row(
              children: [
                Text(
                  worker.firstName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24 * scaleFactor,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  worker?.middleName ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  worker?.lastName ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  worker?.workStatus == WorkStatus.activelyLooking
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
                        worker?.skillIds?.join(', ') ??
                            '', // TODO: Change this to worker?.jobIds?.join(', ') ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        worker?.location!,
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
                Container(
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
                        chatProvider.startRoom(up.appUser, worker);
                        context.push('/chat-message');
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
