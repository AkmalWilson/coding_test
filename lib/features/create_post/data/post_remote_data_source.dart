import 'package:coding_test/core/utils/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSource({required this.dio});

  Future<void> createPost(String title) async {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final token = await SecureStorage().getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Authorization token not found');
    }
    try {
      final response = await dio.post(
        '$baseUrl/dashboard/post',
        data: FormData.fromMap({'title': title}),
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      throw Exception('Error creating post: ${e.toString()}');
    }
  }
}
