import 'package:blukers/models/chat_message.dart';
import 'package:blukers/providers/company_chat_provider.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/views/company/workers_home/workers_components/chat_component.dart';
import 'package:blukers/views/worker/worker_page_template/worker_page_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../common_vieiws/loading_page.dart';
import '../../mobile_company_chat/components/chat_profile_dialogue.dart';


class WebCompanyChatRoomScreen extends StatefulWidget {
  const WebCompanyChatRoomScreen({super.key});

  @override
  State<WebCompanyChatRoomScreen> createState() => _WebCompanyChatRoomScreenState();
}

class _WebCompanyChatRoomScreenState extends State<WebCompanyChatRoomScreen> {
  String textMessage = "";
  int messagesLength = 0;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);

    // Send message function
    onSendMessage() async {
      _textController.clear();
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      await cp.sendMessage(textMessage);
    }

    if (cp.selectedChatRecipient == null) {
      return Center(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const Image(image: AssetImage('assets/images/messenger.png'), height: 200,),
         const SizedBox(height: 20),
          const Text("Welcome To Messages", style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
          const SizedBox(height: 20),
          const Text(
            "Your inbox is waiting. Find your dream job and start\n getting messages from employers.", 
            textAlign: TextAlign.center,
            style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400
          ),),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            context.go("/jobs");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15,
                fontWeight: FontWeight.bold
              )
            ),
            child: const Text("Find Jobs", style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),),
          )
        ],
      ),
      );
    }

    return  Column(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: StreamBuilder<QuerySnapshot>(
                  stream: cp.getMessagesByRoomId(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      List<QueryDocumentSnapshot<Object?>>? messages =
                      snapshot.data?.docs.reversed.toList();
                      return ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          padding: const EdgeInsets.all(10),
                          itemCount: snapshot.data?.docs.length,
                          // reverse: true,
                          // controller: scrollController,
                          itemBuilder: (context, index) {
                            ChatMessage chatMessage = ChatMessage.fromMap(
                                messages![index].data()
                                as Map<String, dynamic>);
                            bool isMe = (chatMessage.sentBy == up.appUser!.uid);
                            return ChatComponent(
                              message: chatMessage.message,
                              isMe: isMe,
                              time: chatMessage.sentAt,
                            );
                          });
                    } else {
                      return const LoadingPage();
                    }
                  }),
            ),
          ),
               Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/attachment.svg',
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _textController,
                        onChanged: (value) {
                          setState(() {
                            textMessage = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // Adjust radius as needed
                          ),
                          suffixIcon: IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/send.svg',
                              color: (textMessage != "")
                                  ? null
                                  : Colors.grey,
                            ),
                            onPressed: () {
                               if (textMessage == "") {
                        return;
                      }
                      onSendMessage();
                      setState(() {
                        textMessage = "";
                      });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.send_outlined,
                  //     color: (textMessage != "")
                  //         ? Colors.blueGrey[900]
                  //         : Colors.grey,
                  //   ),
                  //   onPressed: () {
                  //     if (textMessage == "") {
                  //       return;
                  //     }
                  //     onSendMessage();
                  //     setState(() {
                  //       textMessage = "";
                  //     });
                  //   },
                  // ),
                ],
              ),
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.all(10.0),
          //           child: TextField(
          //             controller: _textController,
          //             onChanged: (value) {
          //               setState(() {
          //                 textMessage = value;
          //               });
          //             },
          //             decoration: InputDecoration(
          //               hintText: 'Type a message',
          //               border: OutlineInputBorder(
          //                 borderRadius: BorderRadius.circular(10.0),
          //                 // Adjust radius as needed
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       IconButton(
          //         icon: Icon(
          //           Icons.send_outlined,
          //           color: (textMessage != "")
          //               ? Colors.blueGrey[900]
          //               : Colors.grey,
          //         ),
          //         onPressed: () {
          //           if (textMessage == "") {
          //             return;
          //           }
          //           onSendMessage();
          //           setState(() {
          //             textMessage = "";
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // )
      
        ],
    );
  }
}


