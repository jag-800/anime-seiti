import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteCollection {
  final String id;
  final String userId;
  final String name;
  final bool isPublic;
  final List<Map<String, dynamic>> locations;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final Timestamp? deletedAt;

  FavoriteCollection({
    required this.id,
    required this.userId,
    required this.name,
    required this.isPublic,
    required this.locations,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory FavoriteCollection.fromFirestore(
    Map<String, dynamic> map,
    String id,
  ) {
    return FavoriteCollection(
      id: id,
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      isPublic: map['isPublic'] ?? false,
      locations: List<Map<String, dynamic>>.from(map['locations'] ?? []),
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
      deletedAt: map['deletedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'name': name,
      'isPublic': isPublic,
      'locations': locations,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
