

import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/providers/worker_chat_provider.dart';
import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:blukers/views/company/company_chat/web_company_chat/components/web_chat_list.dart';
import 'package:blukers/views/company/company_chat/web_company_chat/components/web_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatelessWidget {

  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    WorkerChatProvider wp = Provider.of<WorkerChatProvider>(context);
    int messageCount = wp.unreadMessageCount;
    return Row(
      children: [
           Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Messages",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: ThemeColors.black1ThemeColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          messageCount != 0
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 234, 239, 243),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      messageCount.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      //vertical line
                      const SizedBox(height: 10),
                      const Divider(
                        color: ThemeColors.grey1ThemeColor,
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
                      const Expanded(child: WebCompanyChatList()),
                    ],
                  ),
                ),
              )),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: const WebCompanyChatRoomScreen(),
            ),
          ),
      ],
    );
  }
}