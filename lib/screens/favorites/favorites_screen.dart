import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

import 'components/favorite_item_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productCubit = ProductScreenBloc.object(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<ProductScreenBloc, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return productCubit.userAllFavoriteProduct.isEmpty
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: width,
                        fit: BoxFit.cover,
                        image: const Svg('assets/images/insert.svg'),
                      ),
                      Text(
                        'No Favourites',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontFamily: 'Pacifico'),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return FavoriteItemWidget(
                    height: height,
                    productCubit: productCubit,
                    index: index,
                    states: state as Object,
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                  endIndent: 10,
                  indent: 10,
                ),
                itemCount: productCubit.userAllFavoriteProduct.length,
              );
      },
    );
  }
}
