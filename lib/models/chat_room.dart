class ChatRoom {
  String id;
  String roomName;
  List<String> members;
  String lastMessage;
  String? chatLogo = "";

  ChatRoom(
      {required this.id,
      required this.roomName,
      required this.lastMessage,
      required this.members,
      this.chatLogo});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data["roomName"] = roomName;
    data["members"] = members;
    data["lastMessage"] = lastMessage;
    data["id"] = id;
    data["chatLogo"] = chatLogo;
    return data;
  }

  static ChatRoom fromMap(Map<String, dynamic> map) {
    var membersFromMap = map['members'];
    return ChatRoom(
        id: map["id"],
        roomName: map["roomName"],
        lastMessage: map["lastMessage"],
        members: List<String>.from(membersFromMap),
        chatLogo: map["chatLogo"] ?? "");
  }
}
