import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/cubits/AppCubit/app_cubit.dart';
import 'package:shop_app/cubits/AppCubit/app_states.dart';
import 'package:shop_app/models/category_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppCubit.getAppCubit(context).categoryModel != null
            ? ListView.separated(
                itemBuilder: (context, index) => categoryItemBuilder(
                    AppCubit.getAppCubit(context)
                        .categoryModel!
                        .dataModel!
                        .data[index]),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: AppCubit.getAppCubit(context)
                    .categoryModel!
                    .dataModel!
                    .data
                    .length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget categoryItemBuilder(Data model) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image(
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              image: NetworkImage(
                model.image!,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
