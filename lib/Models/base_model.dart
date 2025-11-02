class BaseModel {
  final String id;
  final int? timeToLive; // _ttl

  BaseModel({
    required this.id,
    this.timeToLive,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      id: json['id'] ?? '',
      timeToLive: json['_ttl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      '_ttl': timeToLive,
    };
  }
}
