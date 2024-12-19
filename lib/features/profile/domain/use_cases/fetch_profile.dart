import 'package:coding_test/features/profile/domain/entities/user.dart';
import 'package:coding_test/features/profile/data/profile_remote_data_source.dart';

class FetchProfile {
  final ProfileRemoteDataSource remoteDataSource;

  FetchProfile({required this.remoteDataSource});

  Future<User> call() async {
    final profileData = await remoteDataSource.fetchProfile();
    return User.fromJson(profileData);
  }
}
