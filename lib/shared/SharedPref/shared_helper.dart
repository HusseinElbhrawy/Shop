import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static late SharedPreferences _sharedPreferences;

  static initShared() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  static setDynamicData({required key, required value}) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value).then((value) {
        print(value);
      }).catchError((error) {
        print('Error $error');
      });
    } else if (value is bool) {
      return await _sharedPreferences.setBool(key, value).then((value) {
        print(value);
      }).catchError((error) {
        print('Error $error');
      });
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value).then((value) {
        print(value);
      }).catchError((error) {
        print('Error $error');
      });
    } else if (value is double) {
      return await _sharedPreferences.setDouble(key, value).then((value) {
        print(value);
      }).catchError((error) {
        print('Error $error');
      });
    }

    return await _sharedPreferences.setStringList(key, value).then((value) {
      print(value);
    }).catchError((error) {
      print('Error $error');
    });
  }

  static getData({required key}) => _sharedPreferences.get(key);

  static deleteValue({required key}) async {
    return await _sharedPreferences.remove(key).then((value) {
      print('Removed Success $value');
    }).catchError((error) {
      print('Error $error');
    });
  }

  static clearAll() async => await _sharedPreferences.clear();
}
