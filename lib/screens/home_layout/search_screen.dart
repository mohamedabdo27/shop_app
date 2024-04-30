import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/cubits/AppCubit/app_cubit.dart';
import 'package:shop_app/cubits/AppCubit/app_states.dart';
import 'package:shop_app/models/search_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.getAppCubit(context);

        Widget body = const Expanded(
          child: SizedBox(
            height: double.infinity,
          ),
        );

        if (cubit.searchModel != null && cubit.favorite.isNotEmpty) {
          body = Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => searchItemBuilder(
                context,
                cubit.searchModel!.data!.data[index],
              ),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.searchModel!.data!.data.length,
            ),
          );
          if (state is SuccessGetSearchDataAppState) {
            if (AppCubit.getAppCubit(context).searchModel!.data!.data.isEmpty) {
              body = const Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: Center(
                    child: Text("No Result"),
                  ),
                ),
              );
            }
          }
        }
        if (state is LoadingGetSearchDataAppState) {
          body = const Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
//**************************************************************
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        cubit.search(text: value);
                      }
                    },
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "please enter your search text";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Text("Enter name to search...."),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.search(text: searchController.text);
                          }
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                    controller: searchController,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                body,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget searchItemBuilder(context, Data model) => Padding(
        padding: const EdgeInsets.all(17.0),
        child: SizedBox(
          height: 120,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    width: 120,
                    height: 120,
                    image: NetworkImage(
                      model.image!,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 18,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 14, fontWeight: FontWeight.bold, height: 0),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "${model.price}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                              ),
                        ),
                        const SizedBox(width: 10),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            AppCubit.getAppCubit(context)
                                .changeFavorite(id: model.id!);
                          },
                          icon: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppCubit.getAppCubit(context)
                                    .favorite[model.id]!
                                ? Colors.green
                                : Colors.grey,
                            child: const Icon(
                              color: Colors.white,
                              Icons.favorite_border_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
