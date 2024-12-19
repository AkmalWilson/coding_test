import 'package:coding_test/features/authentication/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser({required this.repository});

  Future<String> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
