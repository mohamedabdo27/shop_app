import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/BlocObserver/bloc_observer.dart';
import 'package:shop_app/DioHelper/dio_helper.dart';
import 'package:shop_app/cachedData/cached_data.dart';
import 'package:shop_app/cubits/AppCubit/app_cubit.dart';
import 'package:shop_app/screens/home_layout/home_layout.dart';
import 'package:shop_app/screens/login_screeen.dart';
import 'package:shop_app/screens/on_boarding_screen.dart';

String? token = "";
ThemeData theme = ThemeData(
  //primarySwatch: Colors.red,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 32, 201, 74),
  ),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachedData.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();

  bool? onBoardingScreen = CachedData.getBoleanData(key: "onBoardingScreen");
  token = CachedData.getData(key: "token");
  log(token.toString());
  Widget widget;
  if (onBoardingScreen != null) {
    if (token != null) {
      widget = const HomeLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(
    ShopApp(
      widget: widget,
    ),
  );
}

class ShopApp extends StatelessWidget {
  const ShopApp({
    super.key,
    this.widget,
  });
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getHomeData()
        ..getCategoryData()
        ..getFavoriteData()
        ..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: widget,
      ),
    );
  }
}
