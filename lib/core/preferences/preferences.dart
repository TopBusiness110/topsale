import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:topsale/core/models/login_model.dart';

import '../utils/app_strings.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();
  Preferences._internal();
  factory Preferences() => instance;

  ///

  Future<void> setSessionId(String sessionId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('sessionId', sessionId);
    print("sessionId = $sessionId");
  }

  Future<String?> getSessionId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? sessionId = preferences.getString('sessionId');
    return sessionId;
  }
  //*********************************************************

  Future<void> setSessionIdTruUser(String sessionId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('sessionIdTrueUser', sessionId);
    print("sessionIdTrueUser = $sessionId");
  }

  Future<String?> getSessionIdTrueUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? sessionId = preferences.getString('sessionIdTrueUser');
    return sessionId;
  }

  Future<void> isAdmin(bool is_admin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isAdmin', is_admin);
    print("isAdmin = $is_admin");
  }

  Future<bool?> getIsAdmin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isAdmin = preferences.getBool('isAdmin');
    return isAdmin;
  }

  Future<void> setUser2(AuthModel authModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'user2', jsonEncode(AuthModel.fromJson(authModel.toJson())));
    // print(await getUserModel2());
  }

  Future<int?> getPartnerId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? partnerId = preferences.getInt('partnerId');
    return partnerId;
  }

  Future<void> setPartnerId(int partner_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('partnerId', partner_id);
    print("partner_id = $partner_id");
  }

//////////////
  Future<void> saveLanguage(String local) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppStrings.locale, local);
  }

  Future<bool?> getIsFirstTime({required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  Future<dynamic> setIsFirstTime({required String key, required value}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }
  // user  token

  Future<String?> getUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('userToken');
  }

  Future<dynamic> setUserToken({required String value}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('userToken', value);
  }

  Future<void> deleteUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('userToken');
  }
}
