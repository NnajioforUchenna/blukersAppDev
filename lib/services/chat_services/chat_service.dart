import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/company_chat_models/recipient_chat_list_model.dart';

class ChatRepository {

  User? user;

  final CollectionReference chatCollection =  FirebaseFirestore.instance.collection('chats');

  Future<void> storeChatRecipient(ChatRecipientListModel chatRecipient) async {
    print('I have been called to store list of recipient chats');

    final currentUserUid =  user!.uid; // Replace with actual logic
    final chatRecipientMap = chatRecipient.toMap();

    await chatCollection.doc(currentUserUid).set(chatRecipientMap);
  }
}