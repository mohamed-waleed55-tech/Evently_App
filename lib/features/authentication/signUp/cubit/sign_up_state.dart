part of 'sign_up_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterFailure extends RegisterState {
  final String errorMessage;
  RegisterFailure(this.errorMessage);
}

class RegisterPasswordVisibilityChanged extends RegisterState {
  final bool secure;
  final bool resecure;
  RegisterPasswordVisibilityChanged(this.secure, this.resecure);
}
