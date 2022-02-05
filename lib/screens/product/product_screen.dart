import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/screens/product/components/category_widget.dart';
import 'package:new_shop_appl/shared/cubit/bloc/category_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

import 'components/banner_ads_widget.dart';
import 'components/product_item_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var productCubit = ProductScreenBloc.object(context);
    var categoryCubit = CategoryScreenBloc.object(context);
    return BlocConsumer<ProductScreenBloc, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: state is GetHomeDataSuccess ||
              state is GetFavoritesDataLoading ||
              state is GetCategoryDataLoading ||
              state is GetUserProfileDataLoading,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          },
          fallback: (BuildContext context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BannerAdsWidget(cubit: productCubit),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Categories',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? height / 6
                        : height / 3,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryCubit.categoryListData.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryWidget(
                          width: width,
                          image: categoryCubit.categoryListData[index]!.image
                              .toString(),
                          name: categoryCubit.categoryListData[index]!.name
                              .toString(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'New Products',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1 / 1.5,
                    children: List.generate(
                      productCubit.productHomeData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductItemWidget(
                          state: state as Object,
                          condition:
                              productCubit.productHomeData[index].discount != 0,
                          index: index,
                          cubit: productCubit,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
