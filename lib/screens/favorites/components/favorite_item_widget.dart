import 'package:flutter/material.dart';
import 'package:new_shop_appl/screens/product/components/product_image_with_discount.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({
    Key? key,
    required this.height,
    required this.productCubit,
    required this.index,
    required this.states,
  }) : super(key: key);
  final double height;
  final ProductScreenBloc productCubit;
  final int index;
  final Object states;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height / 5.5,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProductImageWithDiscount(
            condition:
                productCubit.userAllFavoriteProduct[index]!.discount != 0,
            cubit: productCubit,
            index: 15,
            imageUrl:
                productCubit.userAllFavoriteProduct[index]!.image.toString(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    productCubit.userAllFavoriteProduct[index]!.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        productCubit.userAllFavoriteProduct[index]!.oldPrice
                            .toString(),
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              decoration: productCubit
                                          .productHomeData[index].discount !=
                                      0
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                      ),
                      Visibility(
                        visible: productCubit
                                .userAllFavoriteProduct[index]!.discount!
                                .toInt() !=
                            0,
                        child: Text(
                          productCubit.userAllFavoriteProduct[index]!.price
                              .toString(),
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                        ),
                      ),
                      states is AddItemToInFavLoading ||
                              states is GetFavoritesDataLoading ||
                              states is PostItemToInFavLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : IconButton(
                              onPressed: () {
                                productCubit.addOrRemoveFormFavorite(
                                  index: index,
                                  id: productCubit
                                      .userAllFavoriteProduct[index]!.id,
                                  context: context,
                                );
                              },
                              icon: productCubit.allFavoritesProductDataId
                                      .contains(
                                productCubit.userAllFavoriteProduct[index]!.id,
                              )
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                    ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
