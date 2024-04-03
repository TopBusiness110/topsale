import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_strings.dart';

class Preferences{
static final Preferences instance = Preferences._internal();
Preferences._internal();
factory Preferences() => instance;


Future<void>  saveLanguage(String local)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(AppStrings.locale, local);
}
 Future<bool?> getIsFirstTime({required String key}) async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return  preferences.getBool(key);
  }

  Future<dynamic> setIsFirstTime({required String key, required value}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return   preferences.setBool(key, value);
  }
  // user  token

  Future<String?> getUserToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString('userToken');
  }

  Future<dynamic> setUserToken({required String value}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return   preferences.setString('userToken', value);
  }
  Future<void> deleteUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('userToken');
  }
}