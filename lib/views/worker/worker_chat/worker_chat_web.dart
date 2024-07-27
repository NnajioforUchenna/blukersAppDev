import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/views/common_vieiws/page_template/page_template.dart';
import 'package:blukers/views/worker/worker_chat/web_worker_chat/worker_chat_room_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/chat_recipient.dart';
import '../../../providers/chat_provider.dart';
import 'components/chat_recipient_widget.dart';

class WorkerChatWeb extends StatelessWidget {
  const WorkerChatWeb({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return StreamBuilder<List<ChatRecipient>>(
      stream: Provider.of<ChatProvider>(context, listen: false)
          .getChatRecipientsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //   return IconText404(
        //     text: AppLocalizations.of(context)!.youHaveNoChats,
        //     icon: UniconsLine.chat,
        //   );
        // }
        return PageTemplate(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9DCDC),
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.2), // Adjust the color and opacity as needed
                        spreadRadius: 2, // Adjust the spread radius as needed
                        blurRadius: 5, // Adjust the blur radius as needed
                        offset:
                            const Offset(0, 3), // Adjust the offset as needed
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ChatRecipientWidget(
                        chatRecipient: snapshot.data![index],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9DCDC),
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.2), // Adjust the color and opacity as needed
                        spreadRadius: 2, // Adjust the spread radius as needed
                        blurRadius: 5, // Adjust the blur radius as needed
                        offset:
                            const Offset(0, 3), // Adjust the offset as needed
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: WorkerChatRoomWeb(),
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9DCDC),
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.2), // Adjust the color and opacity as needed
                        spreadRadius: 2, // Adjust the spread radius as needed
                        blurRadius: 5, // Adjust the blur radius as needed
                        offset:
                            const Offset(0, 3), // Adjust the offset as needed
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Image.network(
                          'https://deleoye.ng/wp-content/uploads/2016/11/Dummy-image.jpg'),
                      const SizedBox(height: 20),
                      const Text(
                        'Display Name',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Text('User description'),
                      const SizedBox(height: 20),
                      const Text('Skills')
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
