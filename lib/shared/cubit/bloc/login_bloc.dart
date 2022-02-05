import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/models/login_model.dart';
import 'package:new_shop_appl/shared/Dio/dio_helper.dart';
import 'package:new_shop_appl/shared/SharedPref/shared_helper.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class LoginBloc extends Cubit<ShopStates> {
  LoginBloc() : super(InitState());
  bool isPasswordHidden = true;

  static LoginBloc object(context) => BlocProvider.of(context);
  changeIcon() {
    isPasswordHidden = !isPasswordHidden;
    emit(ChangeLoginPasswordStateSHOWHIDDEN());
  }

  late LoginModel loginModel;

  String loginMessage = '';
  String userToken = '';

  loginMethod({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    DioHelper.postData(
      path: kLoginPath,
      query: {
        'email': email,
        'password': password,
      },
      headers: {
        'lang': lang,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value);
      if (loginModel.data != null) {
        print(loginModel.data!.token);
        userToken = loginModel.data!.token!;
        SharedHelper.setDynamicData(
          key: kLoginTokenKey,
          value: loginModel.data!.token,
        );
      }

      emit(LoginSuccess(loginModel));
      loginMessage = loginModel.message!;
    }).catchError((error) {
      // loginMessage = loginModel.message.toString();

      print('Error ${error.toString()}');
      emit(LoginFail());
    });
  }

  signOutMethod({required context}) async {
    emit(SignOutLoading());
    await DioHelper.postData(
      path: kLogOutPath,
      query: {
        '': '',
      },
      headers: {
        'lang': lang,
        'Authorization': userToken,
      },
    ).then((value) {
      print('Sign out Success ${value}');
      emit(SignOutSuccess());
      signOut(context);
    }).catchError((error) {
      print('Error happen while sign out $error');
      emit(SignOutFail());
    });
  }
}
