import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/cubit/bloc/category_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var categoryCubit = CategoryScreenBloc.object(context);
    return BlocConsumer<CategoryScreenBloc, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: state is GetCategoryDataLoading,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
          fallback: (BuildContext context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: categoryCubit.categoryListData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? width / 3
                            : width / 5,
                        imageUrl: categoryCubit.categoryListData[index]!.image
                            .toString(),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CachedNetworkImageProgressIndicator(
                          downloadProgress: downloadProgress,
                        ),
                        errorWidget: (context, url, error) =>
                            const CachedNetworkImageErrorWidget(),
                      ),
                      Container(
                        padding: const EdgeInsetsDirectional.all(8),
                        width: width / 2,
                        child: Text(
                          categoryCubit.categoryListData[index]!.name
                              .toString(),
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.black,
                  thickness: 1,
                );
              },
            );
          },
        );
      },
    );
  }
}

/*
ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: categoryCubit.categoryListData.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  minLeadingWidth: 150,
                  title: Text(
                    categoryCubit.categoryListData[index]!.name.toString(),
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  leading: CachedNetworkImage(
                    imageUrl:
                        categoryCubit.categoryListData[index]!.image.toString(),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CachedNetworkImageProgressIndicator(
                      downloadProgress: downloadProgress,
                    ),
                    errorWidget: (context, url, error) =>
                        const CachedNetworkImageErrorWidget(),
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      )),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.black,
                thickness: 1,
              ),
            );
 */
