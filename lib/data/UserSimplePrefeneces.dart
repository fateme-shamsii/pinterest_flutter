import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;
  static const _keyUsername = 'username';
  static const _keypass = 'password';

  static Future init() async =>
  
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences!.setString(_keyUsername, username);
  static String? getUsername() => _preferences!.getString(_keyUsername);
  static Future setPass(int pass) => _preferences!.setInt(_keypass, pass);
  static int? getPass() => _preferences!.getInt(_keypass);
}
