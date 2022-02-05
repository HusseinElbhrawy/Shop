import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/models/favorites_model.dart';
import 'package:new_shop_appl/models/home_model.dart';
import 'package:new_shop_appl/models/product_favorite_model.dart';
import 'package:new_shop_appl/models/profile_model.dart';
import 'package:new_shop_appl/models/update_user_inforamtio_model.dart';
import 'package:new_shop_appl/screens/category/category_screen.dart';
import 'package:new_shop_appl/screens/favorites/favorites_screen.dart';
import 'package:new_shop_appl/screens/product/product_screen.dart';
import 'package:new_shop_appl/screens/settings/settings_screen.dart';
import 'package:new_shop_appl/shared/Dio/dio_helper.dart';
import 'package:new_shop_appl/shared/SharedPref/shared_helper.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class ProductScreenBloc extends Cubit<ShopStates> {
  ProductScreenBloc() : super(HomeScreenState());

  static ProductScreenBloc object(context) => BlocProvider.of(context);
  String loginToken = SharedHelper.getData(key: kLoginTokenKey) ?? '';
  int bottomNavBarCurrentIndex = 0;
  List<Banners> bannerHomeData = [];
  List<Products> productHomeData = [];
  List<int> allProductsId = [];
  List screens = [
    const ProductsScreen(),
    const CategoryScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  changeBottomNavBarCurrentIndex(int index) {
    bottomNavBarCurrentIndex = index;
    emit(ChangeBottomNavBarIndex());
  }

  late HomeModel homeModel;

  getHomeData({authorization, context}) async {
    emit(GetHomeDataLoading());
    await DioHelper.getData(path: kHomePath, query: {
      'Authorization': authorization ?? '',
    }, headers: {
      'lang': lang,
    }).then((value) async {
      homeModel = HomeModel.fromJson(value);
      homeModel.data!.banners!.forEach((element) {
        bannerHomeData.add(element);
      });
      homeModel.data!.products!.forEach((element) {
        productHomeData.add(element);
        allProductsId.add(element.id!.toInt());
      });

      print('Get Data Success');
      emit(GetHomeDataSuccess());
    }).catchError((error) {
      print('Error Happen $error');
      emit(GetHomeDataFails());
    });
  }

  //----------------------------------------------------------------------------------------------------------------------

  List allFavoritesProductDataId = [];
  List<FavoriteProductModelDataDataProduct?> userAllFavoriteProduct = [];
  late FavoriteProductModel favoriteProductModelData;
  getFavoritesProduct() async {
    emit(GetFavoritesDataLoading());
    await DioHelper.getData(
      path: kFavoritesPath,
      headers: {
        'lang': lang,
        'Authorization': loginToken,
      },
    ).then(
      (value) {
        allFavoritesProductDataId = [];
        userAllFavoriteProduct = [];
        favoriteProductModelData = FavoriteProductModel.fromJson(value);
        favoriteProductModelData.data!.data!.forEach((element) {
          allFavoritesProductDataId.add(element!.product!.id);
          userAllFavoriteProduct.add(element.product);
        });
        print(allFavoritesProductDataId);
        emit(GetFavoritesDataSuccess());
      },
    ).catchError((error) {
      print('Error While Getting Fav Data $error');
      emit(GetFavoritesDataFails());
    });
  }

  late FavoritesModel favoritesModel;
  Future _postFavoritesProduct({required id}) {
    emit(PostItemToInFavLoading());
    return DioHelper.postData(path: kFavoritesPath, query: {
      'product_id': id,
    }, headers: {
      'lang': lang,
      'Authorization': loginToken,
    }).then((value) {
      favoritesModel = FavoritesModel.fromJson(value);
      emit(PostItemToInFavSuccess());
    }).catchError((error) {
      print('Error Happen while Add Or Remove Fav $error');
      emit(PostItemToInFavFail());
    });
  }

  addOrRemoveFormFavorite({
    required id,
    required context,
    required index,
  }) {
    emit(AddItemToInFavLoading());
    if (allFavoritesProductDataId.contains(id)) {
      allFavoritesProductDataId.remove(id);
      _postFavoritesProduct(id: id).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(favoritesModel.message.toString()),
            duration: const Duration(seconds: 1),
          ),
        );

        getFavoritesProduct();
        emit(AddItemToInFavSuccess());
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fail'),
            duration: Duration(seconds: 1),
          ),
        );
        emit(AddItemToInFavFail());
      });
    } else {
      allFavoritesProductDataId.add(id);
      _postFavoritesProduct(id: id).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(favoritesModel.message.toString()),
            duration: const Duration(seconds: 1),
          ),
        );
        getFavoritesProduct();
        emit(AddItemToInFavSuccess());
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fail'),
            duration: Duration(seconds: 1),
          ),
        );
        emit(AddItemToInFavFail());
      });
    }
  }

//----------------------------------------------------------------------------------------------------------------------

  late UserProfileModel userProfileModel;
  Map<String, dynamic> userInformation = {};
  getUserProfileData() async {
    emit(GetUserProfileDataLoading());
    await DioHelper.getData(
      path: kProfilePath,
      headers: {
        'lang': lang,
        'Authorization': loginToken,
      },
    ).then((value) {
      userProfileModel = UserProfileModel.fromJson(value);
      userInformation.addAll(
        {
          'name': userProfileModel.data!.name,
          'email': userProfileModel.data!.email,
          'phone': userProfileModel.data!.phone,
          'image': userProfileModel.data!.image,
        },
      );
      print(userProfileModel.data!.name);

      emit(GetUserProfileDataSuccess());
    }).catchError((error) {
      print('Error happen While get profile data $error');
      emit(GetUserProfileDataFails());
    });
  }

//----------------------------------------------------------------------------------------------------------------------

  bool enable = false;
  changeEnable() {
    enable = !enable;
    emit(EnableOrDisableSettingsScreenTextFormFiled());
  }

  late UpdateUserInformationModel updateUserInformationModel;
  updateUserInformation({
    required name,
    required phone,
    required email,
  }) async {
    emit(UpdateUserInformationLoading());
    await DioHelper.putData(
      path: kUpdateProfilePath,
      query: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      headers: {
        'lang': lang,
        'Authorization': loginToken,
      },
    ).then((value) {
      updateUserInformationModel = UpdateUserInformationModel.fromJson(value);
      getUserProfileData();
      emit(UpdateUserInformationSuccess(updateUserInformationModel));
    }).catchError((error) {
      print('Error While update user Data $error ');
      emit(UpdateUserInformationFail());
    });
  }
//----------------------------------------------------------------------------------------------------------------------

}
