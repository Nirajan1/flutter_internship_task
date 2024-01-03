import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static dynamic accessToken;
  static String? userName;
  static String? passWord;

  //? this method is used to store user token locally in secured manner
  static Future storeUserToken(
    String? accessToken,
    String? userName,
    String? passWord,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', accessToken!);
    preferences.setString('username', userName!);
    preferences.setString('password', passWord!);
  }

  //? get stored user data form shared preference
  static Future getUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accessToken = preferences.getString('token');
    userName = preferences.getString('username');
    passWord = preferences.getString('password');
  }

  //? method to log out for the use
  static Future logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.remove('username');
    // preferences.remove('password');
    preferences.remove('token');
  }
}
