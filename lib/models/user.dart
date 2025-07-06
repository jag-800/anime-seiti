import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String displayName;
  final String photoURL;
  final String email;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final Timestamp? deletedAt;

  AppUser({
    required this.id,
    required this.displayName,
    required this.photoURL,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AppUser.fromFirestore(Map<String, dynamic> map, String id) {
    return AppUser(
      id: id,
      displayName: map['displayName'] ?? '',
      photoURL: map['photoURL'] ?? '',
      email: map['email'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
      deletedAt: map['deletedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'displayName': displayName,
      'photoURL': photoURL,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
