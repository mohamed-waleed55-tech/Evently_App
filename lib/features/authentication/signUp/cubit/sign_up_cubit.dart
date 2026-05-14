import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/firebase_service/firestore/auth_service.dart';

part 'sign_up_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  bool secure = true;
  bool resecure = true;

  void togglePassword() {
    secure = !secure;
    emit(RegisterPasswordVisibilityChanged(secure, resecure));
  }

  void toggleRePassword() {
    resecure = !resecure;
    emit(RegisterPasswordVisibilityChanged(secure, resecure));
  }

  void register({required String email, required String password, required String name}) async {
    emit(RegisterLoading());

    final result = await AuthService.register(email, password, name);

    if (result == null) {
      emit(RegisterSuccess());
    } else {
      String message = "Something went wrong";
      if (result == 'weak-password') message = "Weak password";
      if (result == 'email-already-in-use') message = "Email already used";

      emit(RegisterFailure(message));
    }
  }
}
