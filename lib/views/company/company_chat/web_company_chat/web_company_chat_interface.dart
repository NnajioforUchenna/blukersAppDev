
import 'package:blukers/views/company/company_chat/web_company_chat/components/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class WebCompanyChat extends StatefulWidget {
  const WebCompanyChat({super.key});

  @override
  State<WebCompanyChat> createState() => _WebCompanyChatState();
}

class _WebCompanyChatState extends State<WebCompanyChat> {

  int currentPageIndex = 1;

  List<Widget> body = [
    const SizedBox(),
    const MessageScreen(),
    const SizedBox(),
    const SizedBox(),
  ];

  updateBody(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          SizedBox(
            width: 80,
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          updateBody(0);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/idea.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      const SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          updateBody(1);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/messages.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      const SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          updateBody(2);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/calls.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          updateBody(3);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/settings.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          Expanded(
            flex: 3,
            child: body[currentPageIndex],
          ),

          // Expanded(
          //   flex: 3,
          //   child: Container(
          //     height: double.infinity,
          //     margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius:
          //           BorderRadius.circular(15), // Adjust the radius as needed
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(
          //               0.2), // Adjust the color and opacity as needed
          //           spreadRadius: 2, // Adjust the spread radius as needed
          //           blurRadius: 5, // Adjust the blur radius as needed
          //           offset: const Offset(0, 3), // Adjust the offset as needed
          //         ),
          //       ],
          //     ),
          //     padding: const EdgeInsets.all(10),
          //     child: const ChatRecipientProfile(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
