import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:anime_seiti/models/location.dart';

void main() {
  group('Location Model', () {
    final now = Timestamp.now();
    final map = {
      'name': '秋葉原駅前',
      'address': '東京都千代田区外神田1-17-6',
      'coordinates': const GeoPoint(35.6984, 139.7730),
      'verified': true,
      'sceneImages': [
        {'url': 'https://example.com/scene1.png', 'caption': 'シーン1'},
      ],
      'sourceSnippets': [
        {'source': '公式サイト', 'snippet': '第1話で登場'},
      ],
      'tags': ['秋葉原', '駅前'],
      'averageRating': 4.5,
      'reviewCount': 10,
      'createdAt': now,
      'updatedAt': now,
      'deletedAt': null,
    };

    test('fromFirestoreで正しくインスタンス化される', () {
      final location = Location.fromFirestore(map, 'loc1');
      expect(location.id, 'loc1');
      expect(location.name, '秋葉原駅前');
      expect(location.address, '東京都千代田区外神田1-17-6');
      expect(location.coordinates.latitude, 35.6984);
      expect(location.coordinates.longitude, 139.7730);
      expect(location.verified, true);
      expect(location.sceneImages, isA<List<Map<String, dynamic>>>());
      expect(location.sceneImages[0]['url'], 'https://example.com/scene1.png');
      expect(location.sourceSnippets[0]['source'], '公式サイト');
      expect(location.tags, contains('秋葉原'));
      expect(location.averageRating, 4.5);
      expect(location.reviewCount, 10);
      expect(location.createdAt, now);
      expect(location.updatedAt, now);
      expect(location.deletedAt, null);
    });

    test('toFirestoreで正しくMap化される', () {
      final location = Location.fromFirestore(map, 'loc1');
      final firestoreMap = location.toFirestore();
      expect(firestoreMap['name'], '秋葉原駅前');
      expect(firestoreMap['address'], '東京都千代田区外神田1-17-6');
      expect(firestoreMap['coordinates'].latitude, 35.6984);
      expect(firestoreMap['coordinates'].longitude, 139.7730);
      expect(firestoreMap['verified'], true);
      expect(firestoreMap['sceneImages'], isA<List<Map<String, dynamic>>>());
      expect(
        firestoreMap['sceneImages'][0]['url'],
        'https://example.com/scene1.png',
      );
      expect(firestoreMap['sourceSnippets'][0]['source'], '公式サイト');
      expect(firestoreMap['tags'], contains('秋葉原'));
      expect(firestoreMap['averageRating'], 4.5);
      expect(firestoreMap['reviewCount'], 10);
      expect(firestoreMap['createdAt'], now);
      expect(firestoreMap['updatedAt'], now);
      expect(firestoreMap['deletedAt'], null);
    });
  });
}
