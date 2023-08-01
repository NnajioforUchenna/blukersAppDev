class ChatMessage {
  String message;
  DateTime sentAt;
  String sentBy;

  ChatMessage(
      {required this.message, required this.sentAt, required this.sentBy});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data["message"] = message;
    data["sentAt"] = sentAt;
    data["sentBy"] = sentBy;

    return data;
  }

  static ChatMessage fromMap(Map<String, dynamic> map) {
    return ChatMessage(
        message: map["message"], sentAt: (map["sentAt"]).toDate(), sentBy: map["sentBy"]);
  }
}
