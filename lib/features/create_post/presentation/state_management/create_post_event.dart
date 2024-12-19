abstract class CreatePostEvent {}

class SubmitPostEvent extends CreatePostEvent {
  final String title;

  SubmitPostEvent({required this.title});
}
