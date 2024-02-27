import '../../../core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefDataSource {
  Future<bool> getThemeStatus();
  Future<void> storeData(bool isDark);
}

class SharedPrefDataSourceImpl implements SharedPrefDataSource {
  final _prefs = SharedPreferences.getInstance();

  @override
  Future<bool> getThemeStatus() async {
    final SharedPreferences prefs = await _prefs;

    try {
      final themeStatus = prefs.getBool("theme_status");
      if (themeStatus == null) {
        storeData(false);
        return false;
      } else {
        return themeStatus;
      }
    } catch (e) {
      throw SharedPreferenceException();
    }
  }

  @override
  Future<void> storeData(bool isDark) async {
    final SharedPreferences prefs = await _prefs;
    try {
      await prefs.setBool("theme_status", isDark);
    } catch (e) {
      throw SharedPreferenceException();
    }
  }
}
