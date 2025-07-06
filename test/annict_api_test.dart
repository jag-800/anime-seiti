import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../lib/secrets.dart';

void main() {
  test('Annict API接続テスト', () async {
    final accessToken = annictAccessToken;
    expect(accessToken, isNotNull);

    final url = Uri.parse(
      'https://api.annict.com/v1/works?filter_season=2024-spring',
    );
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
    expect(response.statusCode, 200);
  });
}
