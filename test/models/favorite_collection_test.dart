import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:anime_seiti/models/favorite_collection.dart';

void main() {
  group('FavoriteCollection Model', () {
    final now = Timestamp.now();
    final map = {
      'userId': 'user1',
      'name': '週末行く東京聖地',
      'isPublic': true,
      'locations': [
        {'id': 'loc1', 'name': '秋葉原駅前'},
        {'id': 'loc2', 'name': '神田明神'},
      ],
      'createdAt': now,
      'updatedAt': now,
      'deletedAt': null,
    };

    test('fromFirestoreで正しくインスタンス化される', () {
      final fav = FavoriteCollection.fromFirestore(map, 'fav1');
      expect(fav.id, 'fav1');
      expect(fav.userId, 'user1');
      expect(fav.name, '週末行く東京聖地');
      expect(fav.isPublic, true);
      expect(fav.locations, isA<List<Map<String, dynamic>>>());
      expect(fav.locations.length, 2);
      expect(fav.locations[0]['name'], '秋葉原駅前');
      expect(fav.createdAt, now);
      expect(fav.updatedAt, now);
      expect(fav.deletedAt, null);
    });

    test('toFirestoreで正しくMap化される', () {
      final fav = FavoriteCollection.fromFirestore(map, 'fav1');
      final firestoreMap = fav.toFirestore();
      expect(firestoreMap['userId'], 'user1');
      expect(firestoreMap['name'], '週末行く東京聖地');
      expect(firestoreMap['isPublic'], true);
      expect(firestoreMap['locations'], isA<List<Map<String, dynamic>>>());
      expect(firestoreMap['locations'][0]['name'], '秋葉原駅前');
      expect(firestoreMap['createdAt'], now);
      expect(firestoreMap['updatedAt'], now);
      expect(firestoreMap['deletedAt'], null);
    });
  });
}
