import 'package:blukers/services/generate_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../models/company_chat_models/recipient_chat_list_model.dart';
import '../../../../providers/job_posts_provider.dart';
import '../../../Modules/select_by_industry/select_by_industry.dart';
import 'components/company_chat_list_item_widget.dart';

class CompanyChatList extends StatefulWidget {
  const CompanyChatList({super.key});

  @override
  State<CompanyChatList> createState() => _CompanyChatListState();
}

class _CompanyChatListState extends State<CompanyChatList> {
  final List<ChatRecipientListModel> _chatList = [
    ChatRecipientListModel(
      uid: 'uid',
      displayName: 'displayName',
      email: 'email',
      photoUrl: 'photoUrl',
      lastMessageTimestamp: Timestamp.now(),
    ),

    ChatRecipientListModel(
      uid: 'uid',
      displayName: 'displayName',
      email: 'email',
      photoUrl: 'photoUrl',
      lastMessageTimestamp: Timestamp.now(),
      unreadMessageCount: 34
    ),
  ];

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Company Chat List'),
      ),
      body: ListView.builder(
        itemCount: _chatList.length,
        itemBuilder: (context, index) {
          return ChatListItemWidget(chatListItem: _chatList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectByIndustry(
                  selectBy: 'jobs',
                  getRecords: jp.getJobPostsByJobID,
                ),
              ));
        },
        backgroundColor: Colors.deepOrangeAccent,
        icon: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        label: const Text('Chat a worker'),
      ),
    );
  }
}
