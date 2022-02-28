import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedpref;

  static inti() async {
    sharedpref = await SharedPreferences.getInstance();
  }

  static getData({required dynamic key}) async {
    dynamic ret = await sharedpref!.get(key);
    return ret;
  }

  static setData({required String key, required dynamic value}) async {
    if (value is String) {
      dynamic ret = await sharedpref!.setString(key, value);
      return ret;
    }
    if (value is bool) {
      dynamic ret = await sharedpref!.setBool(key, value);
      return ret;
    }
  }
}
