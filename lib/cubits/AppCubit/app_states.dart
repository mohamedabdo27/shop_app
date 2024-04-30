import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';

class AppStates {}

class InitialAppState extends AppStates {}

class NavBarAppState extends AppStates {}

class LoadingHomeDataAppState extends AppStates {}

class SuccessHomeDataAppState extends AppStates {}

class ErrorHomeDataAppState extends AppStates {}

class SuccessCategoryDataAppState extends AppStates {}

class ErrorCategoryDataAppState extends AppStates {}

class SuccessChangeFavoriteAppState extends AppStates {
  final ChangeFavoriteModel changeFavoriteModel;

  SuccessChangeFavoriteAppState({required this.changeFavoriteModel});
}

class ErrorChangeFavoriteAppState extends AppStates {}

class LoadingChangeFavoriteAppState extends AppStates {}

class SuccessGetFavoriteDataAppState extends AppStates {
  final FavoriteModel favoritModel;

  SuccessGetFavoriteDataAppState({required this.favoritModel});
}

class ErrorGetFavoriteDataAppState extends AppStates {}

class LoadingGetFavoriteDataAppState extends AppStates {}

class SuccessGetUserDataAppState extends AppStates {
  final LoginModel userModel;

  SuccessGetUserDataAppState({required this.userModel});
}

class ErrorGetUserDataAppState extends AppStates {}

class LoadingGetUserDataAppState extends AppStates {}

class SuccessUpdateUserDataAppState extends AppStates {
  final LoginModel userModel;

  SuccessUpdateUserDataAppState({required this.userModel});
}

class ErrorUpdateUserDataAppState extends AppStates {}

class LoadingUpdateUserDataAppState extends AppStates {}

class SuccessGetSearchDataAppState extends AppStates {
  final SearchModel? searchModel;

  SuccessGetSearchDataAppState({required this.searchModel});
}

class ErrorGetSearchDataAppState extends AppStates {
  final String error;

  ErrorGetSearchDataAppState({required this.error});
}

class LoadingGetSearchDataAppState extends AppStates {}
