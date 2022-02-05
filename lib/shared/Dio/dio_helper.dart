import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dioHelper;
  static initDio() async {
    _dioHelper = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future postData({required path, required query, headers}) async {
    return await _dioHelper
        .post(
      path,
      queryParameters: query,
      options: Options(
        headers: headers,
      ),
    )
        .then(
      (value) {
        return value.data;
      },
    ).catchError((error) {
      print('Error Happen White put data $error');
    });
  }

  static Future getData({required path, query, headers}) async {
    return await _dioHelper
        .get(path, queryParameters: query, options: Options(headers: headers))
        .then((value) {
      return value.data;
    }).catchError((error) {
      print('Error Happen while get data $error');
    });
  }

  static Future putData({required path, required query, headers}) async {
    return await _dioHelper
        .put(
      path,
      queryParameters: query,
      options: Options(
        headers: headers,
      ),
    )
        .then((value) {
      return value.data;
    }).catchError((error) {
      print('Error While Put Data $error');
    });
  }
}
