class CompanyChatMessageModel {
  final String messageId;
  final String senderId;
  final String recipientId;
  final String messageBody;
  final DateTime timestamp;

  CompanyChatMessageModel({
    required this.messageId,
    required this.senderId,
    required this.recipientId,
    required this.messageBody,
    required this.timestamp,
  });

  // Method to convert a message to a map (useful for serialization)
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'recipientId': recipientId,
      'messageBody': messageBody,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Method to create a message from a map (useful for deserialization)
  factory CompanyChatMessageModel.fromMap(Map<String, dynamic> map) {
    return CompanyChatMessageModel(
      messageId: map['messageId'],
      senderId: map['senderId'],
      recipientId: map['recipientId'],
      messageBody: map['messageBody'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
