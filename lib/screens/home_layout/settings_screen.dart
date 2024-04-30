import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cachedData/cached_data.dart';
import 'package:shop_app/cubits/AppCubit/app_cubit.dart';
import 'package:shop_app/cubits/AppCubit/app_states.dart';
import 'package:shop_app/screens/login_screeen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is SuccessGetUserDataAppState) {
          nameController.text = state.userModel.logindata!.name!;
          emailController.text = state.userModel.logindata!.email!;
          phoneController.text = state.userModel.logindata!.phone!;
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.getAppCubit(context);
        if (cubit.userDataModel != null) {
          nameController.text = cubit.userDataModel!.logindata!.name!;
          emailController.text = cubit.userDataModel!.logindata!.email!;
          phoneController.text = cubit.userDataModel!.logindata!.phone!;
        }

        return cubit.userDataModel != null
            ? Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (state is LoadingUpdateUserDataAppState)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "the name mustn't be empty";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Name"),
                              prefixIcon: Icon(Icons.person_2_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "the phone mustn't be empty";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Phone"),
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "the email mustn't be empty";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Email address"),
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AppCubit.getAppCubit(context).updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              child: Text(
                                "UPDATE",
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                CachedData.removeData(
                                  key: "token",
                                ).then((value) {
                                  if (value!) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => const LoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                });
                              },
                              child: Text(
                                "LOGOUT",
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
