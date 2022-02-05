import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/main.dart';
import 'package:new_shop_appl/models/search_product.dart';
import 'package:new_shop_appl/shared/Dio/dio_helper.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class SearchScreenBloc extends Cubit<ShopStates> {
  SearchScreenBloc() : super(InitSearchScreen());

  static SearchScreenBloc object(context) => BlocProvider.of(context);

  SearchProducts searchProductsModel = SearchProducts();
  List<SearchProductsInnerData> searchProductList = [];
  productSearch({required productName}) async {
    emit(SearchProductLoading());
    await DioHelper.postData(
      path: kSearchProductsPath,
      query: {'text': productName},
      headers: {
        'lang': lang,
        'Authorization': MyApp.loginToken,
      },
    ).then((value) {
      searchProductList = [];
      searchProductsModel = SearchProducts.fromJson(value);
      searchProductsModel.data!.data!.forEach((element) {
        searchProductList.add(element!);
      });
      print(searchProductList.length);
      emit(SearchProductSuccess());
    }).catchError((error) {
      print('Error Happen While search $error');
      emit(SearchProductFail());
    });
  }
}
