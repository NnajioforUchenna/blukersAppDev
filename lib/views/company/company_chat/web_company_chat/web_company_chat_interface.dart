import 'package:blukers/views/company/company_chat/web_company_chat/components/chat_recipient_profile.dart';
import 'package:blukers/views/company/company_chat/web_company_chat/components/web_chat_screen.dart';
import 'package:flutter/material.dart';

import 'components/web_chat_list.dart';

class WebCompanyChat extends StatefulWidget {
  const WebCompanyChat({super.key});

  @override
  State<WebCompanyChat> createState() => _WebCompanyChatState();
}

class _WebCompanyChatState extends State<WebCompanyChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
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
                child: const WebCompanyChatList()),
          ),
          Expanded(
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
          Expanded(
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
              child: const ChatRecipientProfile(),
            ),
          ),
        ],
      ),
    );
  }
}
