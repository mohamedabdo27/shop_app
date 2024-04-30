import 'package:shop_app/models/login_model.dart';

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final LoginModel loginModel;

  SuccessLoginState({required this.loginModel});
}

class ErrorLoginState extends LoginState {
  final String error;

  ErrorLoginState(this.error);
}

class VisibilityPasswordLoginState extends LoginState {}
