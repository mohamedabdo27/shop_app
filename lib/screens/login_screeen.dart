import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cachedData/cached_data.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/cubits/LoginCubit/login_cubit.dart';
import 'package:shop_app/cubits/LoginCubit/login_state.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/home_layout/home_layout.dart';
import 'package:shop_app/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailaddressController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            if (state.loginModel.status!) {
              CachedData.putData(
                key: "token",
                value: state.loginModel.logindata!.token,
              ).then((value) {
                if (value!) {
                  token = state.loginModel.logindata!.token;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const HomeLayout(),
                      ),
                      (route) => false);
                }
              });
            } else {
              showToast(
                message: state.loginModel.message!,
                state: toastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.getLoginCubit(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          "login now to browse our hot offers",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "please enter your email address";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label: Text("Email address"),
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                          controller: emailaddressController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.loginPost(
                                email: emailaddressController.text,
                                password: passwordController.text,
                              );
                              log("validate");
                            }
                          },
                          obscureText: cubit.isVisible,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "password is too short";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeVisibility();
                              },
                              icon: Icon(cubit.isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state is! LoadingLoginState
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                width: double.infinity,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.loginPost(
                                        email: emailaddressController.text,
                                        password: passwordController.text,
                                      );

                                      log("validate");
                                    }
                                  },
                                  child: Text(
                                    "LOGIN",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account ?"),
                            const SizedBox(
                              width: 15,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text("REGISTER"))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
