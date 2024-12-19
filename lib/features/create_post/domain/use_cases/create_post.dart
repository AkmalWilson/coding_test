import 'package:coding_test/features/create_post/data/post_remote_data_source.dart';

class CreatePost {
  final PostRemoteDataSource remoteDataSource;

  CreatePost({required this.remoteDataSource});

  Future<void> call(String title) async {
    await remoteDataSource.createPost(title);
  }
}
