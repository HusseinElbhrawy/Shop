import 'package:new_shop_appl/models/login_model.dart';
import 'package:new_shop_appl/models/register_model.dart';
import 'package:new_shop_appl/models/update_user_inforamtio_model.dart';

abstract class ShopStates {}

class InitState extends ShopStates {}

class HomeScreenState extends ShopStates {}

class ChangeLoginPasswordStateSHOWHIDDEN extends ShopStates {}

class ChangeRegisterPasswordStateSHOWHIDDEN extends ShopStates {}

class LoginSuccess extends ShopStates {
  final LoginModel loginModel;

  LoginSuccess(this.loginModel);
}

class LoginFail extends ShopStates {}

class LoginLoading extends ShopStates {}

class SignOutLoading extends ShopStates {}

class SignOutSuccess extends ShopStates {}

class SignOutFail extends ShopStates {}

class ChangeBottomNavBarIndex extends ShopStates {}

class GetHomeDataSuccess extends ShopStates {}

class GetHomeDataFails extends ShopStates {}

class GetHomeDataLoading extends ShopStates {}

class AddItemToInFavLoading extends ShopStates {}

class AddItemToInFavSuccess extends ShopStates {}

class AddItemToInFavFail extends ShopStates {}

class PostItemToInFavLoading extends ShopStates {}

class PostItemToInFavSuccess extends ShopStates {}

class PostItemToInFavFail extends ShopStates {}

class GetFavoritesDataLoading extends ShopStates {}

class GetFavoritesDataSuccess extends ShopStates {}

class GetFavoritesDataFails extends ShopStates {}

class CategoryScreenState extends ShopStates {}

class GetCategoryDataSuccess extends ShopStates {}

class GetCategoryDataFails extends ShopStates {}

class GetCategoryDataLoading extends ShopStates {}

class GetUserProfileDataSuccess extends ShopStates {}

class GetUserProfileDataFails extends ShopStates {}

class GetUserProfileDataLoading extends ShopStates {}

class FavoriteScreenState extends ShopStates {}

class RegisterState extends ShopStates {}

class RegisterSuccess extends ShopStates {
  final RegisterModel registerModel;

  RegisterSuccess(this.registerModel);
}

class RegisterLoading extends ShopStates {}

class RegisterFail extends ShopStates {}

class UpdateUserInformationLoading extends ShopStates {}

class UpdateUserInformationSuccess extends ShopStates {
  late UpdateUserInformationModel updateUserInformationModel;
  UpdateUserInformationSuccess(this.updateUserInformationModel);
}

class UpdateUserInformationFail extends ShopStates {}

class EnableOrDisableSettingsScreenTextFormFiled extends ShopStates {}

class InitSearchScreen extends ShopStates {}

class SearchProductLoading extends ShopStates {}

class SearchProductSuccess extends ShopStates {}

class SearchProductFail extends ShopStates {}
