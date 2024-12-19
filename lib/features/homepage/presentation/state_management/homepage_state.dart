import 'package:coding_test/features/homepage/domain/entities/post.dart';

abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageLoaded extends HomepageState {
  final List<Post> posts;

  HomepageLoaded({required this.posts});
}

class HomepageError extends HomepageState {
  final String message;

  HomepageError({required this.message});
}
