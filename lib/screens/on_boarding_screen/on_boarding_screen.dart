import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:new_shop_appl/screens/login/login_screen.dart';
import 'package:new_shop_appl/shared/SharedPref/shared_helper.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;
  var pageViewController = PageController();
  List images = [
    'assets/images/accept.svg',
    'assets/images/add_to_cart.svg',
    'assets/images/welcome.svg',
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              SharedHelper.setDynamicData(key: konBoardKey, value: true);
              navigateToWithReplacement(
                context: context,
                nextPage: const LoginScreen(),
              );
            },
            child: const Text('Skip'),
          ),
        ],
      ),
      floatingActionButton: Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(start: width / 10),
            child: SmoothPageIndicator(
              controller: pageViewController, // PageController
              count: 3,
              effect: const WormEffect(), // your preferred effect
              onDotClicked: (index) {},
            ),
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () {
              if (index < 2) {
                pageViewController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              } else {
                SharedHelper.setDynamicData(key: konBoardKey, value: true);
                navigateToWithReplacement(
                  context: context,
                  nextPage: const LoginScreen(),
                );
              }
            },
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Image(
            height: height / 1.5,
            width: width,
            image: Svg(images[index]),
          );
        },
        itemCount: 3,
        controller: pageViewController,
        onPageChanged: (newIndex) {
          index = newIndex;
          setState(() {});
        },
      ),
    );
  }
}
