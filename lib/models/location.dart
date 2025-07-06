import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final String id;
  final String name;
  final String address;
  final GeoPoint coordinates;
  final bool verified;
  final List<Map<String, dynamic>> sceneImages;
  final List<Map<String, dynamic>> sourceSnippets;
  final List<String> tags;
  final double averageRating;
  final int reviewCount;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final Timestamp? deletedAt;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.coordinates,
    required this.verified,
    required this.sceneImages,
    required this.sourceSnippets,
    required this.tags,
    required this.averageRating,
    required this.reviewCount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Location.fromFirestore(Map<String, dynamic> map, String id) {
    return Location(
      id: id,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      coordinates: map['coordinates'] ?? const GeoPoint(0, 0),
      verified: map['verified'] ?? false,
      sceneImages: List<Map<String, dynamic>>.from(map['sceneImages'] ?? []),
      sourceSnippets: List<Map<String, dynamic>>.from(
        map['sourceSnippets'] ?? [],
      ),
      tags: List<String>.from(map['tags'] ?? []),
      averageRating: (map['averageRating'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
      deletedAt: map['deletedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'address': address,
      'coordinates': coordinates,
      'verified': verified,
      'sceneImages': sceneImages,
      'sourceSnippets': sourceSnippets,
      'tags': tags,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
