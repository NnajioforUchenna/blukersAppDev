class ChatRoom {
  String id;
  List<String> names;
  List<String> members;
  String lastMessage;
  List<String> chatLogo = [];

  ChatRoom(
      {required this.id,
      required this.names,
      required this.lastMessage,
      required this.members,
      this.chatLogo = const ["", ""]});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data["names"] = names;
    data["members"] = members;
    data["lastMessage"] = lastMessage;
    data["id"] = id;
    data["chatLogo"] = chatLogo;
    return data;
  }

  static ChatRoom fromMap(Map<String, dynamic> map) {
    var membersFromMap = map['members'];
    var namesFromMap = map['names'];
    var chatLogoFromMap = map['chatLogo'];
    return ChatRoom(
        id: map["id"],
        names: List<String>.from(namesFromMap),
        lastMessage: map["lastMessage"],
        members: List<String>.from(membersFromMap),
        chatLogo: List<String>.from(chatLogoFromMap));
  }
}
