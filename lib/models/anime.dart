import 'package:cloud_firestore/cloud_firestore.dart';

class Anime {
  final String id;
  final String title;
  final String mainVisualUrl;
  final int broadcastYear;
  final int annictId;
  final int locationCount;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final Timestamp? deletedAt;

  Anime({
    required this.id,
    required this.title,
    required this.mainVisualUrl,
    required this.broadcastYear,
    required this.annictId,
    required this.locationCount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Anime.fromFirestore(Map<String, dynamic> map, String id) {
    return Anime(
      id: id,
      title: map['title'] ?? '',
      mainVisualUrl: map['mainVisualUrl'] ?? '',
      broadcastYear: map['broadcastYear'] ?? 0,
      annictId: map['annictId'] ?? 0,
      locationCount: map['locationCount'] ?? 0,
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
      deletedAt: map['deletedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'mainVisualUrl': mainVisualUrl,
      'broadcastYear': broadcastYear,
      'annictId': annictId,
      'locationCount': locationCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
