import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/firebase_service/firestore/auth_service.dart';

part 'forget_password_state.dart';


class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    emit(ForgetPasswordLoading());

    final result = await AuthService.resetPassword(
      emailController.text.trim(),
    );

    if (result != null) {
      emit(ForgetPasswordError(result));
    } else {
      emit(ForgetPasswordSuccess("Password reset email sent. Check your inbox."));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}