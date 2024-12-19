abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;

  UpdateProfileEvent({required this.name});
}
