import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';

class ProductImageWithDiscount extends StatelessWidget {
  const ProductImageWithDiscount({
    Key? key,
    required this.cubit,
    required this.index,
    required this.imageUrl,
    required this.condition,
  }) : super(key: key);
  final int index;
  final ProductScreenBloc cubit;
  final String imageUrl;
  final bool condition;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CachedNetworkImageProgressIndicator(
                      downloadProgress: downloadProgress),
              errorWidget: (context, url, error) =>
                  const CachedNetworkImageErrorWidget(),
            ),
          ),
          Visibility(
            visible: condition,
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
    );
  }
}
