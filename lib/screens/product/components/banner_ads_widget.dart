import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';

class BannerAdsWidget extends StatelessWidget {
  const BannerAdsWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final ProductScreenBloc cubit;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      itemCount: cubit.bannerHomeData.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return const Icon(
                Icons.error,
                color: Colors.blue,
              );
            },
            imageUrl: cubit.bannerHomeData[index].image.toString(),
          ),
        );
      },
    );
  }
}
