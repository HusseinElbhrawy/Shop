import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/models/register_model.dart';
import 'package:new_shop_appl/shared/Dio/dio_helper.dart';
import 'package:new_shop_appl/shared/SharedPref/shared_helper.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class RegisterBloc extends Cubit<ShopStates> {
  RegisterBloc() : super(RegisterState());

  static RegisterBloc object(context) => BlocProvider.of(context);

  bool isPasswordHidden = true;
  changeIcon() {
    isPasswordHidden = !isPasswordHidden;
    emit(ChangeRegisterPasswordStateSHOWHIDDEN());
  }

  String userToken = '';
  late RegisterModel registerModel;
  registerMethod({
    required name,
    required email,
    required password,
    required phone,
  }) async {
    emit(RegisterLoading());
    await DioHelper.postData(
      path: kRegisterPath,
      query: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
      headers: {'lang': lang},
    ).then((value) {
      registerModel = RegisterModel.fromJson(value);
      if (registerModel.data != null) {
        print(registerModel.data!.token);
        userToken = registerModel.data!.token!;
        SharedHelper.setDynamicData(
          key: kLoginTokenKey,
          value: registerModel.data!.token,
        );
      }
      emit(RegisterSuccess(registerModel));
    }).catchError((error) {
      print('Error while register $error');
      emit(RegisterFail());
    });
  }
}
