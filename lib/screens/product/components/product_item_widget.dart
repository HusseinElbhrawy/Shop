import 'package:flutter/material.dart';
import 'package:new_shop_appl/screens/product/components/product_image_with_discount.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.cubit,
    required this.index,
    required this.condition,
    required this.state,
  }) : super(key: key);
  final int index;
  final ProductScreenBloc cubit;
  final bool condition;
  final Object state;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImageWithDiscount(
          condition: cubit.productHomeData[index].discount != 0,
          cubit: cubit,
          index: index,
          imageUrl: cubit.productHomeData[index].image.toString(),
        ),
        Text(
          cubit.productHomeData[index].name.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cubit.productHomeData[index].oldPrice.toString(),
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    decoration: cubit.productHomeData[index].discount != 0
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
            ),
            Visibility(
              visible: condition,
              child: Text(
                cubit.productHomeData[index].price.toString(),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
              ),
            ),
            state is AddItemToInFavLoading ||
                    state is GetFavoritesDataLoading ||
                    state is PostItemToInFavLoading
                ? const Center(child: CircularProgressIndicator())
                : IconButton(
                    onPressed: () {
                      cubit.addOrRemoveFormFavorite(
                        index: index,
                        id: cubit.productHomeData[index].id,
                        context: context,
                      );
                    },
                    icon: cubit.allFavoritesProductDataId
                            .contains(cubit.productHomeData[index].id)
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
      ],
    );
  }
}
