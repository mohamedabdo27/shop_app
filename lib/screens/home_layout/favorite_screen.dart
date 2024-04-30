import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/cubits/AppCubit/app_cubit.dart';
import 'package:shop_app/cubits/AppCubit/app_states.dart';
import 'package:shop_app/models/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // if (state is SuccessGetFavoriteDataAppState) {
        //   if (state.favoritModel.data!.data.isEmpty) {
        //     return Text("offffug");
        //   }
        // //    }
        // if (AppCubit.getAppCubit(context).favoriteModel!.data!.data.isEmpty) {
        //   return Center(
        //       child: Text(
        //     "No Favorite Products",
        //     style: Theme.of(context).textTheme.bodyLarge,
        //   ));
        // }
        return AppCubit.getAppCubit(context).favorite.isNotEmpty &&
                AppCubit.getAppCubit(context).favoriteModel != null
            ? ListView.separated(
                itemBuilder: (context, index) => faVoriteItemBuilder(
                    context,
                    AppCubit.getAppCubit(context)
                        .favoriteModel!
                        .data!
                        .data[index]),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: AppCubit.getAppCubit(context)
                    .favoriteModel!
                    .data!
                    .data
                    .length,
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget faVoriteItemBuilder(context, Data model) => Padding(
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
                      model.favoriteProductData!.image!,
                    ),
                  ),
                  if (model.favoriteProductData!.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.red,
                      child: const Text(
                        "DISCOUND",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
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
                      model.favoriteProductData!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 14, fontWeight: FontWeight.bold, height: 0),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "${model.favoriteProductData!.price}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                              ),
                        ),
                        const SizedBox(width: 10),
                        if (model.favoriteProductData!.discount != 0)
                          Text(
                            "${model.favoriteProductData!.oldPrice}",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            AppCubit.getAppCubit(context).changeFavorite(
                                id: model.favoriteProductData!.id!);
                          },
                          icon: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppCubit.getAppCubit(context)
                                    .favorite[model.favoriteProductData!.id]!
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
