import 'package:flutter_bloc/flutter_bloc.dart';
import 'homepage_event.dart';
import 'homepage_state.dart';
import 'package:coding_test/features/homepage/domain/use_cases/fetch_posts.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final FetchPosts fetchPosts;

  HomepageBloc({required this.fetchPosts}) : super(HomepageInitial()) {
    on<FetchPostsEvent>((event, emit) async {
      emit(HomepageLoading());
      try {
        final posts = await fetchPosts();
        emit(HomepageLoaded(posts: posts));
      } catch (e) {
        emit(HomepageError(message: e.toString()));
      }
    });
  }
}
