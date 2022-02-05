import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/screens/home/home_screen.dart';
import 'package:new_shop_appl/screens/login/login_screen.dart';
import 'package:new_shop_appl/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:new_shop_appl/shared/Dio/dio_helper.dart';
import 'package:new_shop_appl/shared/SharedPref/shared_helper.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:new_shop_appl/shared/cubit/bloc/category_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/bloc/login_bloc.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/bloc/register_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/bloc/search_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.initShared();
  DioHelper.initDio();
  print(SharedHelper.getData(key: kLoginTokenKey));
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final onBoardingDone = SharedHelper.getData(key: konBoardKey) ?? false;
  static final String loginToken =
      SharedHelper.getData(key: kLoginTokenKey) ?? '';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginBloc()),
        BlocProvider(
          create: (BuildContext context) => ProductScreenBloc()
            ..getHomeData(authorization: loginToken)
            ..getFavoritesProduct()
            ..getUserProfileData(),
        ),
        BlocProvider(
          create: (BuildContext context) => CategoryScreenBloc()..getCategory(),
        ),
        BlocProvider(
          create: (BuildContext context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => SearchScreenBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            color: Colors.white,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
        ),
        // home: const HomeScreen(),
        home: ConditionalBuilder(
          condition: onBoardingDone,
          builder: (BuildContext context) =>
              loginToken == null || loginToken.isEmpty
                  ? const LoginScreen()
                  : const HomeScreen(),
          fallback: (BuildContext context) => const OnBoardingScreen(),
        ),
      ),
    );
  }
}
