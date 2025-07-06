import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/anime.dart';
import '../services/firestore_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../secrets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 検索状態
class SearchState {
  final bool isLoading;
  final List<Anime> results;
  final String? error;
  final bool searched;
  final bool fromAnnict;

  SearchState({
    this.isLoading = false,
    this.results = const [],
    this.error,
    this.searched = false,
    this.fromAnnict = false,
  });

  SearchState copyWith({
    bool? isLoading,
    List<Anime>? results,
    String? error,
    bool? searched,
    bool? fromAnnict,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      error: error,
      searched: searched ?? this.searched,
      fromAnnict: fromAnnict ?? this.fromAnnict,
    );
  }
}

class SearchViewModel extends StateNotifier<SearchState> {
  final FirestoreService firestoreService;
  SearchViewModel(this.firestoreService) : super(SearchState());

  Future<void> search(String title) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      searched: false,
      fromAnnict: false,
    );
    try {
      final results = await firestoreService.searchAnimeByTitle(title);
      if (results.isNotEmpty) {
        state = state.copyWith(
          isLoading: false,
          results: results,
          error: null,
          searched: true,
          fromAnnict: false,
        );
        return;
      }
      // FirestoreにヒットしなければAnnict APIで検索
      final annictResults = await searchAnnictApi(title);
      state = state.copyWith(
        isLoading: false,
        results: annictResults,
        error: null,
        searched: true,
        fromAnnict: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        searched: true,
        fromAnnict: false,
      );
    }
  }

  Future<List<Anime>> searchAnnictApi(String title) async {
    final accessToken = annictAccessToken;
    if (accessToken.isEmpty) {
      throw Exception('Annictアクセストークンが設定されていません');
    }
    final url = Uri.parse(
      'https://api.annict.com/v1/works?filter_title=$title',
    );
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List works = data['works'] ?? [];
      return works.map<Anime>((work) {
        return Anime(
          id: work['id'].toString(),
          title: work['title'] ?? '',
          mainVisualUrl: work['images']?['recommended_url'] ?? '',
          broadcastYear:
              int.tryParse((work['season_name_text'] ?? '').split('-').first) ??
              0,
          annictId: work['id'] ?? 0,
          locationCount: 0,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
          deletedAt: null,
        );
      }).toList();
    } else {
      throw Exception('Annict APIエラー: ${response.statusCode}');
    }
  }
}

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>((ref) {
      return SearchViewModel(FirestoreService());
    });
