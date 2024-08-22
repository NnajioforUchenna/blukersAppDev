
class Message {
  final String sender;
  final String content;
  final DateTime timestamp;
  final Message? replyTo;
  final String subject;
  final String receiver;

  Message({required this.sender, required this.content, required this.timestamp, required this.replyTo, required this.subject, required this.receiver, required List<String?> attachments});
}

