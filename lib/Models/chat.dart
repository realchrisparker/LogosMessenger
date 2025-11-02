import 'base_model.dart';

class Chat extends BaseModel {
  final String conversationId;
  final String senderId;
  final String message;
  final bool isEncrypted;
  final DateTime createdAt;

  Chat({
    required super.id,
    super.timeToLive,
    required this.conversationId,
    required this.senderId,
    required this.message,
    required this.isEncrypted,
    required this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] ?? '',
      timeToLive: json['_ttl'],
      conversationId: json['conversationId'] ?? '',
      senderId: json['senderId'] ?? '',
      message: json['message'] ?? '',
      isEncrypted: json['isEncrypted'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      '_ttl': timeToLive,
      'conversationId': conversationId,
      'senderId': senderId,
      'message': message,
      'isEncrypted': isEncrypted,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
