import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:anime_seiti/models/user.dart';

void main() {
  group('AppUser Model', () {
    final now = Timestamp.now();
    final map = {
      'displayName': 'テストユーザー',
      'photoURL': 'https://example.com/photo.png',
      'email': 'test@example.com',
      'createdAt': now,
      'updatedAt': now,
      'deletedAt': null,
    };

    test('fromFirestoreで正しくインスタンス化される', () {
      final user = AppUser.fromFirestore(map, 'user1');
      expect(user.id, 'user1');
      expect(user.displayName, 'テストユーザー');
      expect(user.photoURL, 'https://example.com/photo.png');
      expect(user.email, 'test@example.com');
      expect(user.createdAt, now);
      expect(user.updatedAt, now);
      expect(user.deletedAt, null);
    });

    test('toFirestoreで正しくMap化される', () {
      final user = AppUser.fromFirestore(map, 'user1');
      final firestoreMap = user.toFirestore();
      expect(firestoreMap['displayName'], 'テストユーザー');
      expect(firestoreMap['photoURL'], 'https://example.com/photo.png');
      expect(firestoreMap['email'], 'test@example.com');
      expect(firestoreMap['createdAt'], now);
      expect(firestoreMap['updatedAt'], now);
      expect(firestoreMap['deletedAt'], null);
    });
  });
}
