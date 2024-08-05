import 'package:blukers/views/worker/worker_chat/web_worker_chat/worker_chat_room_web.dart';
import 'package:blukers/views/worker/worker_page_template/worker_page_template.dart';
import 'package:flutter/material.dart';

import 'components/chat_recipient_widget.dart';

class DummyWorkerChatWeb extends StatelessWidget {
  const DummyWorkerChatWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkerPageTemplate(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFD9DCDC),
                borderRadius:
                    BorderRadius.circular(15), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                        0.2), // Adjust the color and opacity as needed
                    spreadRadius: 2, // Adjust the spread radius as needed
                    blurRadius: 5, // Adjust the blur radius as needed
                    offset: const Offset(0, 3), // Adjust the offset as needed
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ChatRecipientWidget(
                      // chatRecipient: snapshot.data![index],
                      );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFD9DCDC),
                borderRadius:
                    BorderRadius.circular(15), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                        0.2), // Adjust the color and opacity as needed
                    spreadRadius: 2, // Adjust the spread radius as needed
                    blurRadius: 5, // Adjust the blur radius as needed
                    offset: const Offset(0, 3), // Adjust the offset as needed
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: WorkerChatRoomWeb(),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFD9DCDC),
                borderRadius:
                    BorderRadius.circular(15), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                        0.2), // Adjust the color and opacity as needed
                    spreadRadius: 2, // Adjust the spread radius as needed
                    blurRadius: 5, // Adjust the blur radius as needed
                    offset: const Offset(0, 3), // Adjust the offset as needed
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              // child: const ChatRecipientDetails(),
            ),
          ),
        ],
      ),
    );
    //   },
    // );
  }
}
