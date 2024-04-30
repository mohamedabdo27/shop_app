import 'package:shop_app/models/login_model.dart';

class RegisterStates {}

class InitialeRegisterState extends RegisterStates {}

class LoadingRegisterState extends RegisterStates {}

class SuccessRegisterState extends RegisterStates {
  final LoginModel registerModel;

  SuccessRegisterState({required this.registerModel});
}

class ErrorRegisterState extends RegisterStates {
  final String error;

  ErrorRegisterState(this.error);
}

class VisibilityPasswordRegisterState extends RegisterStates {}
