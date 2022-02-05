import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/screens/search/search_screen.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/cubit/bloc/login_bloc.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ProductScreenBloc.object(context);
    var loginCubit = LoginBloc.object(context);

    return BlocConsumer<ProductScreenBloc, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context: context,
                    nextPage: const SearchScreen(),
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.bottomNavBarCurrentIndex,
            onTap: (newValue) {
              cubit.changeBottomNavBarCurrentIndex(newValue);
            },
            items: const [
              BottomNavigationBarItem(
                  label: 'Product', icon: Icon(Icons.home_outlined)),
              BottomNavigationBarItem(
                  label: 'Category', icon: Icon(Icons.apps_outlined)),
              BottomNavigationBarItem(
                  label: 'Favorites',
                  icon: Icon(Icons.favorite_border_outlined)),
              BottomNavigationBarItem(
                  label: 'Settings', icon: Icon(Icons.settings_outlined)),
            ],
          ),
          body: cubit.screens[cubit.bottomNavBarCurrentIndex],
        );
      },
    );
  }
}
