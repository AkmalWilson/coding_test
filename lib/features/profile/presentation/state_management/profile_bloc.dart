import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'package:coding_test/features/profile/domain/use_cases/fetch_profile.dart';
import 'package:coding_test/features/profile/data/profile_remote_data_source.dart';
import 'package:coding_test/features/profile/domain/entities/user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchProfile fetchProfile;
  final ProfileRemoteDataSource remoteDataSource;

  ProfileBloc({required this.fetchProfile, required this.remoteDataSource})
      : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await fetchProfile();
        emit(ProfileLoaded(user: user));
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      try {
        if (state is ProfileLoaded) {
          emit(ProfileLoading());
          await remoteDataSource.updateProfile(event.name);

          final updatedUser = await fetchProfile();
          emit(ProfileLoaded(user: updatedUser));
          emit(ProfileUpdatedSuccess());
        }
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });
  }
}
