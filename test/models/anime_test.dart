import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:anime_seiti/models/anime.dart';

void main() {
  group('Anime Model', () {
    final now = Timestamp.now();
    final map = {
      'title': 'テストアニメ',
      'mainVisualUrl': 'https://example.com/image.png',
      'broadcastYear': 2024,
      'annictId': 12345,
      'locationCount': 2,
      'createdAt': now,
      'updatedAt': now,
      'deletedAt': null,
    };

    test('fromFirestoreで正しくインスタンス化される', () {
      final anime = Anime.fromFirestore(map, 'animeId1');
      expect(anime.id, 'animeId1');
      expect(anime.title, 'テストアニメ');
      expect(anime.mainVisualUrl, 'https://example.com/image.png');
      expect(anime.broadcastYear, 2024);
      expect(anime.annictId, 12345);
      expect(anime.locationCount, 2);
      expect(anime.createdAt, now);
      expect(anime.updatedAt, now);
      expect(anime.deletedAt, null);
    });

    test('toFirestoreで正しくMap化される', () {
      final anime = Anime.fromFirestore(map, 'animeId1');
      final firestoreMap = anime.toFirestore();
      expect(firestoreMap['title'], 'テストアニメ');
      expect(firestoreMap['mainVisualUrl'], 'https://example.com/image.png');
      expect(firestoreMap['broadcastYear'], 2024);
      expect(firestoreMap['annictId'], 12345);
      expect(firestoreMap['locationCount'], 2);
      expect(firestoreMap['createdAt'], now);
      expect(firestoreMap['updatedAt'], now);
      expect(firestoreMap['deletedAt'], null);
    });
  });
}
