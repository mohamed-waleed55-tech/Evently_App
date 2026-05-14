import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/firebase_service/firestore/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool isSecure = true;

  void togglePasswordVisibility() {
    isSecure = !isSecure;
    emit(PasswordVisibilityChanged(isSecure));
  }

  void login(String email, String password) async {
    emit(LoginLoading());
    final result = await AuthService.login(email.trim(), password);

    if (result == null) {
      emit(LoginSuccess());
    } else {
      String message = "Login failed";
      if (result == 'invalid-credential') message = "Email or password is incorrect";
      if (result == 'user-not-found') message = "User not found";

      emit(LoginFailure(message));
    }
  }

  void loginWithGoogle() async {
    emit(LoginLoading());
    final user = await AuthService.signInWithGoogle();
    if (user != null) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure("Google Login Failed"));
    }
  }
}