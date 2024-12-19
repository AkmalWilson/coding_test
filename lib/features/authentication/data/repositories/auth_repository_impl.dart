import 'package:coding_test/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:coding_test/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }
}
