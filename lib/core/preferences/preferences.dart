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
}