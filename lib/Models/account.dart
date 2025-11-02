import 'base_model.dart';

class Account extends BaseModel {
  final String userName;
  final String email;
  final String phoneNumber;
  final String phoneNumberCountryCode;
  final String publicKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;
  final String? photoUrl;

  Account({
    required super.id,
    super.timeToLive,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.phoneNumberCountryCode,
    required this.publicKey,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.photoUrl,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] ?? '',
      timeToLive: json['_ttl'],
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      phoneNumberCountryCode: json['phoneNumberCountryCode'] ?? '',
      publicKey: json['publicKey'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      lastLoginAt: json['lastLoginAt'] != null ? DateTime.parse(json['lastLoginAt']) : null,
      photoUrl: json['photoUrl'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      '_ttl': timeToLive,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'phoneNumberCountryCode': phoneNumberCountryCode,
      'publicKey': publicKey,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'photoUrl': photoUrl,
    };
  }
}
