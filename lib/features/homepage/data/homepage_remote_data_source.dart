import 'package:coding_test/core/utils/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomepageRemoteDataSource {
  final Dio dio;

  HomepageRemoteDataSource({required this.dio});

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final token = await SecureStorage().getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Authorization token not found');
    }
    try {
      final response = await dio.get('$baseUrl/post?token=$token');
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
