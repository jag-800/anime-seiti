import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/search_view_model.dart';
import '../models/anime.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchViewModelProvider);
    final viewModel = ref.read(searchViewModelProvider.notifier);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('アニメ聖地検索')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'アニメタイトルを入力',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) => viewModel.search(value),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => viewModel.search(controller.text),
                child: const Text('検索'),
              ),
            ),
            const SizedBox(height: 24),
            if (state.isLoading) const CircularProgressIndicator(),
            if (state.error != null)
              Text(
                'エラー: ${state.error}',
                style: const TextStyle(color: Colors.red),
              ),
            if (state.searched &&
                !state.isLoading &&
                state.results.isEmpty &&
                state.error == null)
              Text('お探しの「${controller.text}」はまだ登録されていません...'),
            if (state.results.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    final Anime anime = state.results[index];
                    return ListTile(
                      title: Text(anime.title),
                      subtitle: Text('Annict ID: ${anime.annictId}'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
