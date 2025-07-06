import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/anime.dart';
import '../models/location.dart';
import '../models/favorite_collection.dart';

class FirestoreService {
  final FirebaseFirestore firestore;

  FirestoreService({FirebaseFirestore? firestore})
    : firestore = firestore ?? FirebaseFirestore.instance;

  // アニメタイトルで検索
  Future<List<Anime>> searchAnimeByTitle(String title) async {
    final query = await firestore
        .collection('animes')
        .where('title', isGreaterThanOrEqualTo: title)
        .where('title', isLessThan: title + '\uf8ff')
        .get();
    return query.docs
        .map((doc) => Anime.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  // アニメIDに紐づく聖地リスト取得
  Future<List<Location>> getLocationsForAnime(String animeId) async {
    final query = await firestore
        .collection('animes')
        .doc(animeId)
        .collection('locations')
        .get();
    return query.docs
        .map((doc) => Location.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  // お気に入りコレクション作成
  Future<void> createFavoriteCollection(FavoriteCollection collection) async {
    await firestore
        .collection('favorite_collections')
        .doc(collection.id)
        .set(collection.toFirestore());
  }

  // 必要に応じて他のCRUDメソッドも追加
}
