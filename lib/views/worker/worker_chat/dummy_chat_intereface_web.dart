import 'package:blukers/views/common_vieiws/page_template/page_template.dart';
import 'package:blukers/views/worker/worker_chat/web_worker_chat/worker_chat_room_web.dart';
import 'package:flutter/material.dart';
import 'components/chat_recipient_details.dart';
import 'components/chat_recipient_widget.dart';

class DummyWorkerChatWeb extends StatelessWidget {
  const DummyWorkerChatWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // UserProvider up = Provider.of<UserProvider>(context);
    // return up.appUser == null
    //     ? const LoginOrRegister()
    //     : StreamBuilder<List<ChatRecipient>>(
    //   stream: Provider.of<ChatProvider>(context, listen: false)
    //       .getChatRecipientsStream(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: const CircularProgressIndicator());
    //     }
    //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       return IconText404(
    //         text: AppLocalizations.of(context)!.youHaveNoChats,
    //         icon: UniconsLine.chat,
    //       );
    //     }
    return PageTemplate(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFD9DCDC),
                borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Adjust the color and opacity as needed
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
                borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Adjust the color and opacity as needed
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
                borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Adjust the color and opacity as needed
                    spreadRadius: 2, // Adjust the spread radius as needed
                    blurRadius: 5, // Adjust the blur radius as needed
                    offset: const Offset(0, 3), // Adjust the offset as needed
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: ChatRecipientDetails(),
            ),
          ),
        ],
      ),
    );
    //   },
    // );
  }
}







