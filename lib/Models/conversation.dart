import 'base_model.dart';

class Conversation extends BaseModel {
  final String conversationId;
  final List<String> participantIds;
  final String? title;
  final DateTime createdAt;
  final DateTime? lastMessageAt;

  Conversation({
    required super.id,
    super.timeToLive,
    required this.conversationId,
    required this.participantIds,
    this.title,
    required this.createdAt,
    this.lastMessageAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] ?? '',
      timeToLive: json['_ttl'],
      conversationId: json['conversationId'] ?? '',
      participantIds: (json['participantIds'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      lastMessageAt: json['lastMessageAt'] != null ? DateTime.parse(json['lastMessageAt']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      '_ttl': timeToLive,
      'conversationId': conversationId,
      'participantIds': participantIds,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'lastMessageAt': lastMessageAt?.toIso8601String(),
    };
  }
}
