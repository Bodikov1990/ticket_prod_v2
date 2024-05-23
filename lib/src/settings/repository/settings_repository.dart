import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_prod_v2/main.dart';
import 'package:ticket_prod_v2/src/settings/data/models/settings_model.dart';

class SettingsRepository {
  static const String SETTINGS_KEY = "SETTINGS_KEY";

  Future<bool> setEnv(Environment env) async {
    await clear();
    SettingsModel settings = SettingsModel();
    settings.env = env;
    await saveSettings(settings);
    return true;
  }

  Future<Environment?> getEnv() async {
    SettingsModel settings = await getSettings();
    return settings.env;
  }

  Future<SettingsModel> saveSettings(SettingsModel settings) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    try {
      String jsonString = settings.toJsonString();
      await sharedPreferences.setString(SETTINGS_KEY, jsonString);
      // ignore: empty_catches
    } catch (ignored) {}
    return settings;
  }

  Future<SettingsModel> getSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    SettingsModel settingsModel;
    try {
      String? jsonString = sharedPreferences.getString(SETTINGS_KEY);
      if (jsonString != null) {
        settingsModel = SettingsModel.fromJsonString(jsonString);
      } else {
        settingsModel = SettingsModel();
        settingsModel.env = DEFAULT_ENV;
      }
    } catch (ignored) {
      settingsModel = SettingsModel();
    }
    return settingsModel;
  }

  Future<bool> clear() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.clear();
  }
}
