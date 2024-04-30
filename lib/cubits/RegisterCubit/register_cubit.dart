import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/DioHelper/dio_helper.dart';
import 'package:shop_app/cubits/RegisterCubit/register_state.dart';
import 'package:shop_app/models/login_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialeRegisterState());
  static RegisterCubit getRegisterCubit(context) => BlocProvider.of(context);
  bool isVisible = true;
  void changeVisibility() {
    isVisible = !isVisible;
    emit(VisibilityPasswordRegisterState());
  }
//****************************************** */

  LoginModel? registerModel;
  registerPost({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(LoadingRegisterState());
    DioHelper.post(url: "register", data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
    }).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      //print(value.data);
      print(registerModel!.status);
      emit(SuccessRegisterState(registerModel: registerModel!));
    }).catchError((onError) {
      emit(ErrorRegisterState(onError));
    });
  }
}
