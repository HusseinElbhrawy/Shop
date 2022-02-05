import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_shop_appl/shared/config/components.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {Key? key, required this.width, required this.image, required this.name})
      : super(key: key);
  final double width;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width / 3.0,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          CachedNetworkImage(
            imageUrl: image.toString(),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CachedNetworkImageProgressIndicator(
              downloadProgress: downloadProgress,
            ),
            errorWidget: (context, url, error) =>
                const CachedNetworkImageErrorWidget(),
          ),
          Container(
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
            color: Colors.black.withOpacity(.6),
          ),
        ],
      ),
    );
  }
}
