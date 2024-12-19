import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_post_event.dart';
import 'create_post_state.dart';
import 'package:coding_test/features/create_post/domain/use_cases/create_post.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePost createPost;

  CreatePostBloc({required this.createPost}) : super(CreatePostInitial()) {
    on<SubmitPostEvent>((event, emit) async {
      emit(CreatePostLoading());
      try {
        await createPost(event.title);
        emit(CreatePostSuccess());
      } catch (e) {
        emit(CreatePostError(message: e.toString()));
      }
    });
  }
}
