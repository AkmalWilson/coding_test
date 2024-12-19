import 'package:coding_test/features/homepage/domain/entities/post.dart';
import 'package:coding_test/features/homepage/data/homepage_remote_data_source.dart';

class FetchPosts {
  final HomepageRemoteDataSource remoteDataSource;

  FetchPosts({required this.remoteDataSource});

  Future<List<Post>> call() async {
    final postData = await remoteDataSource.fetchPosts();
    return postData.map((data) => Post.fromJson(data)).toList();
  }
}
