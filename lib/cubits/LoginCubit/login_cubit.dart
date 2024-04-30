import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/DioHelper/dio_helper.dart';
import 'package:shop_app/cubits/LoginCubit/login_state.dart';
import 'package:shop_app/models/login_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit getLoginCubit(BuildContext context) =>
      BlocProvider.of(context);
  bool isVisible = true;
  void changeVisibility() {
    isVisible = !isVisible;
    emit(VisibilityPasswordLoginState());
  }

  LoginModel? loginModel;
  void loginPost({
    required String email,
    required String password,
  }) {
    emit(LoadingLoginState());
    DioHelper.post(
      url: "login",
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(
        SuccessLoginState(
          loginModel: loginModel!,
        ),
      );
    }).catchError((onError) {
      emit(ErrorLoginState(onError));
    });
  }
}
