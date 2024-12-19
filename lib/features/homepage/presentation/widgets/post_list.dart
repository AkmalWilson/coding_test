import 'package:coding_test/features/homepage/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:coding_test/features/homepage/presentation/widgets/post_card.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;

  const PostList({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index]);
      },
    );
  }
}
