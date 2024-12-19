import 'package:coding_test/core/utils/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource({required this.dio});

  Future<Map<String, dynamic>> fetchProfile() async {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final token = await SecureStorage().getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Authorization token not found');
    }

    try {
      final response = await dio.get(
        '$baseUrl/dashboard/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch profile: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error fetching profile: ${e.toString()}');
    }
  }

  Future<void> updateProfile(String name) async {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final token = await SecureStorage().getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token not found');
    }

    try {
      await dio.put(
        '$baseUrl/dashboard/profile',
        data: {'name': name},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      throw Exception('Error updating profile: ${e.toString()}');
    }
  }
}
