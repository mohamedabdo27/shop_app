import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/cubits/AppCubit/app_cubit.dart';
import 'package:shop_app/cubits/AppCubit/app_states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is SuccessChangeFavoriteAppState) {
          if (!state.changeFavoriteModel.status!) {
            showToast(
                message: state.changeFavoriteModel.message!,
                state: toastState.error);
          }
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.getAppCubit(context);
        return cubit.homeModel != null && cubit.categoryModel != null
            ? productBuilder(cubit.homeModel!, cubit.categoryModel!, context)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

Widget productBuilder(HomeModel model, CategoryModel categoryModel, context) =>
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Image(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      e.image!,
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              height: 250,
              autoPlayCurve: Curves.fastOutSlowIn,
              reverse: false,
              autoPlayInterval: const Duration(seconds: 5),
              enableInfiniteScroll: true,
              initialPage: 0,
              viewportFraction: 1,
              scrollDirection: Axis.horizontal,
              // disableCenter: true,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => categoryBuilder(
                      categoryModel.dataModel!.data[index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 15,
                    ),
                    itemCount: categoryModel.dataModel!.data.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "New Product",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.5,
              children: List.generate(
                model.data!.products.length,
                (index) =>
                    gridViewBuilder(model.data!.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );
Widget gridViewBuilder(ProductsModel model, context) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              width: double.infinity,
              height: 150,
              // fit: BoxFit.cover,
              image: NetworkImage(model.image!),
            ),
            if (model.discoung != 0)
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
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
              Row(
                children: [
                  Text(
                    "${model.price}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(width: 10),
                  if (model.discoung != 0)
                    Text(
                      "${model.oldPrice}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      AppCubit.getAppCubit(context)
                          .changeFavorite(id: model.id!);
                    },
                    icon: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          AppCubit.getAppCubit(context).favorite[model.id]!
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
  );
}

Widget categoryBuilder(Data model) => Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(
          width: 100,
          height: 100,
          image: NetworkImage(
            model.image!,
          ),
          fit: BoxFit.cover,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(.6),
          child: Text(
            model.name!,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
