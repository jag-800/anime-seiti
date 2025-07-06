import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final accessToken = dotenv.env['ANNICT_TOKEN'];
  if (accessToken == null) {
    print('アクセストークンが.envに設定されていません');
    return;
  }

  final url = Uri.parse(
    'https://api.annict.com/v1/works?filter_season=2024-spring',
  );
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('Annict API接続成功:');
    print(data);
  } else {
    print('Annict API接続失敗: ${response.statusCode}');
    print(response.body);
  }
}
