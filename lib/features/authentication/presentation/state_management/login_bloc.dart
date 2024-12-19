import 'package:coding_test/core/utils/secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:coding_test/features/authentication/domain/use_cases/login_user.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;

  LoginBloc({required this.loginUser}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final token = await loginUser(event.email, event.password);
        emit(LoginSuccess(token: token));

        SecureStorage().saveToken(token);
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
