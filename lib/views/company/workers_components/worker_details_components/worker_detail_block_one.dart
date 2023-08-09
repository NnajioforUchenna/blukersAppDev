import 'package:bulkers/models/worker.dart';
import 'package:bulkers/providers/worker_provider.dart';
import 'package:bulkers/services/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';
import '../../../../services/notification_service.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../common_views/worker_timeline/display_worker_timeline_dialog.dart';

class WorkerDetailBlockOne extends StatelessWidget {
  final Worker worker;
  const WorkerDetailBlockOne({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    UserProvider up = Provider.of<UserProvider>(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    bool isWorkerSaved = up.isWorkerSaved(worker.workerId ?? '');
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
        children: [
          Center(
            child: RoundedImageWidget(
                imageUrl:
                    worker.profilePhotoUrl ?? 'https://picsum.photos/200/300',
                size: 100),
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
                worker?.firstName ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
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
                width: width < 600
                    ? 100
                    : 200, // 300 on mobile, 500 on web or tablet
                height: width < 600 ? 40 : 70,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.secondaryThemeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded edges
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20 // Bigger text
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
                      String roomId = await chatProvider?.createChatRoom(
                          myUid: up.appUser!.uid,
                          recipientUid: worker.workerId,
                          myName: up.appUser!.displayName ?? "Company",
                          recipientName: worker.firstName + worker.lastName,
                          message: "",
                          myLogo: up.appUser!.photoUrl ?? "",
                          recipientLogo: worker.profilePhotoUrl ?? "");
                      chatProvider?.activeRoomId = roomId;
                      Navigator.pushNamed(context, '/chat-message', arguments: {
                        "roomId": roomId,
                        "roomName": worker.firstName + worker.lastName,
                      });
                    }
                  },
                ),
              )
            ],
          ),
          const Divider(),
        ],
      ),
      // Add padding around the edges
    );
  }
}
