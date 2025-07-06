import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:anime_seiti/services/firestore_service.dart';
import 'package:anime_seiti/models/anime.dart';
import 'package:anime_seiti/models/location.dart';
import 'package:anime_seiti/models/favorite_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('FirestoreService', () {
    late FakeFirebaseFirestore fakeFirestore;
    late FirestoreService service;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      service = FirestoreService(firestore: fakeFirestore);
      // FirestoreServiceのインスタンスにfakeFirestoreを注入できるように、
      // 必要ならFirestoreService側の実装を修正してください。
    });

    test('searchAnimeByTitle returns empty list by default', () async {
      final result = await service.searchAnimeByTitle('テスト');
      expect(result, isEmpty);
    });

    test('getLocationsForAnime returns empty list by default', () async {
      final result = await service.getLocationsForAnime('animeId1');
      expect(result, isEmpty);
    });

    test('createFavoriteCollection completes without error', () async {
      final fav = FavoriteCollection(
        id: 'fav1',
        userId: 'user1',
        name: 'コレクション',
        isPublic: true,
        locations: [],
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        deletedAt: null,
      );
      await service.createFavoriteCollection(fav);
      // 実装後はFirestoreにデータが追加されているか検証
    });
  });
}
