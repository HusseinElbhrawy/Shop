import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/models/category_model.dart';
import 'package:new_shop_appl/shared/Dio/dio_helper.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class CategoryScreenBloc extends Cubit<ShopStates> {
  CategoryScreenBloc() : super(CategoryScreenState());

  static CategoryScreenBloc object(context) => BlocProvider.of(context);

  late CategoryModel categoryModel;
  List<InnerData?> categoryListData = [];
  Future getCategory() async {
    emit(GetCategoryDataLoading());
    return await DioHelper.getData(path: kCategoryPath, headers: {'lang': lang})
        .then((value) {
      categoryModel = CategoryModel.fromJson(value);
      categoryModel.data!.data!.forEach((element) {
        categoryListData.add(element);
      });
      emit(GetCategoryDataSuccess());
      return value;
    }).catchError((error) {
      print('Error Happen White get category $error');
      emit(GetCategoryDataFails());
    });
  }
}
