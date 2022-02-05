import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/bloc/search_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var productCubit = ProductScreenBloc.object(context);
    var searchCubit = SearchScreenBloc.object(context);
    return BlocConsumer<SearchScreenBloc, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    searchCubit.productSearch(
                        productName: searchController.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          body: state is SearchProductLoading
              ? const LinearProgressIndicator()
              : searchCubit.searchProductList.isEmpty &&
                      state is SearchProductSuccess
                  ? Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              height: width,
                              fit: BoxFit.cover,
                              image: const Svg('assets/images/cancel.svg'),
                            ),
                            Text(
                              "Not Found !",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontFamily: 'Pacifico'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : searchCubit.searchProductList.isEmpty
                      ? Center(
                          child: Text(
                            'Try To Search',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontFamily: 'Pacifico'),
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) => SizedBox(
                            height: height / 5.5,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomStart,
                                    children: [
                                      Center(
                                        child: CachedNetworkImage(
                                          imageUrl: searchCubit
                                              .searchProductList[index].image
                                              .toString(),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CachedNetworkImageProgressIndicator(
                                                  downloadProgress:
                                                      downloadProgress),
                                          errorWidget: (context, url, error) =>
                                              const CachedNetworkImageErrorWidget(),
                                        ),
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: Container(
                                          color: Colors.red,
                                          child: const Text(
                                            'DISCOUNT',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          searchCubit
                                              .searchProductList[index].name
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      BlocConsumer<ProductScreenBloc,
                                          ShopStates>(
                                        listener:
                                            (BuildContext context, state) {},
                                        builder: (BuildContext context,
                                            Object? state) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                searchCubit
                                                    .searchProductList[index]
                                                    .price
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      decoration: productCubit
                                                                  .productHomeData[
                                                                      index]
                                                                  .discount !=
                                                              0
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                    ),
                                              ),
                                              state is AddItemToInFavLoading ||
                                                      state
                                                          is GetFavoritesDataLoading ||
                                                      state
                                                          is PostItemToInFavLoading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        productCubit
                                                            .addOrRemoveFormFavorite(
                                                          index: index,
                                                          id: searchCubit
                                                              .searchProductList[
                                                                  index]
                                                              .id,
                                                          context: context,
                                                        );
                                                      },
                                                      icon: productCubit
                                                              .allFavoritesProductDataId
                                                              .contains(
                                                        searchCubit
                                                            .searchProductList[
                                                                index]
                                                            .id,
                                                      )
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_border_outlined,
                                                            ),
                                                    ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: searchCubit.searchProductList.length,
                        ),
        );
      },
    );
  }
}
