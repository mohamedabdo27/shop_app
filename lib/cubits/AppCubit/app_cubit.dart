import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/DioHelper/dio_helper.dart';
import 'package:shop_app/cubits/AppCubit/app_states.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/screens/home_layout/category_screen.dart';
import 'package:shop_app/screens/home_layout/favorite_screen.dart';
import 'package:shop_app/screens/home_layout/product_screen.dart';
import 'package:shop_app/screens/home_layout/settings_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit getAppCubit(context) => BlocProvider.of(context);

  int currentIndex = 0;
  void changeNavBar(int index) {
    currentIndex = index;
    emit(NavBarAppState());
  }

  List<Widget> screens = [
    const ProductScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    SettingScreen(),
  ];
  //**************************************************
  Map<int, bool> favorite = {};
  HomeModel? homeModel;
  void getHomeData() {
    emit(LoadingHomeDataAppState());
    DioHelper.get(
      url: "home",
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorite.addAll({
          element.id!: element.inFavorite!,
          // log(element.toString())
        });
      });
      log(favorite.toString());
      emit(SuccessHomeDataAppState());
    }).catchError((error) {
      emit(ErrorHomeDataAppState());
    });
  }

  //************************************************
  CategoryModel? categoryModel;
  void getCategoryData() {
    DioHelper.get(
      url: "categories",
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(SuccessCategoryDataAppState());
    }).catchError((error) {
      emit(ErrorCategoryDataAppState());
    });
  }

  //*********************************************************
  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorite({required int id}) {
    emit(LoadingChangeFavoriteAppState());
    favorite[id] = !favorite[id]!;
    DioHelper.post(
      url: "favorites",
      token: token,
      data: {
        "product_id": id,
      },
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      getFavoriteData();
      if (!changeFavoriteModel!.status!) {
        favorite[id] = !favorite[id]!;
      }
      emit(SuccessChangeFavoriteAppState(
          changeFavoriteModel: changeFavoriteModel!));
    }).catchError((onError) {
      favorite[id] = !favorite[id]!;

      emit(ErrorChangeFavoriteAppState());
    });
  }

  //==============================================================
  FavoriteModel? favoriteModel;
  void getFavoriteData() {
    emit(LoadingGetFavoriteDataAppState());

    DioHelper.get(
      url: "favorites",
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(SuccessGetFavoriteDataAppState(favoritModel: favoriteModel!));
    }).catchError((onError) {
      emit(ErrorGetFavoriteDataAppState());
    });
  }

  //===========================================================
  LoginModel? userDataModel;
  void getUserData() {
    emit(LoadingGetUserDataAppState());
    DioHelper.get(
      url: "profile",
      token: token,
    ).then((value) {
      userDataModel = LoginModel.fromJson(value.data);
      emit(SuccessGetUserDataAppState(userModel: userDataModel!));
    }).catchError((onError) {
      emit(ErrorGetUserDataAppState());
    });
  }
//===========================================================

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(LoadingUpdateUserDataAppState());
    DioHelper.put(
      url: "update-profile",
      token: token,
      data: {
        "name": name,
        "phone": phone,
        "email": email,
      },
    ).then((value) {
      userDataModel = LoginModel.fromJson(value.data);
      emit(SuccessUpdateUserDataAppState(userModel: userDataModel!));
    }).catchError((onError) {
      emit(ErrorUpdateUserDataAppState());
    });
  }

//===========================================================
  SearchModel? searchModel;
  void search({
    required String text,
  }) {
    emit(LoadingGetSearchDataAppState());
    DioHelper.post(
      url: "products/search",
      data: {
        "text": text,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessGetSearchDataAppState(searchModel: searchModel));
      log(searchModel!.status!.toString());
    }).catchError((onError) {
      emit(ErrorGetSearchDataAppState(error: onError.toString()));
      print(onError.toString());
    });
  }
}
