import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared_preferences_provider.dart';

part 'settings_provider.g.dart';

class SettingsProvider {
  final SharedPreferences _prefs;

  SettingsProvider(this._prefs);

  static const _keyVolume = 'audio_volume';
  static const _keyQuality = 'audio_quality';
  static const _keyAutoPlay = 'audio_auto_play';

  double getVolume() => _prefs.getDouble(_keyVolume) ?? 0.5;
  Future<void> setVolume(double value) => _prefs.setDouble(_keyVolume, value);

  int getQuality() => _prefs.getInt(_keyQuality) ?? 128;
  Future<void> setQuality(int value) => _prefs.setInt(_keyQuality, value);

  bool getAutoPlay() => _prefs.getBool(_keyAutoPlay) ?? false;
  Future<void> setAutoPlay(bool value) => _prefs.setBool(_keyAutoPlay, value);
}

@riverpod
SettingsProvider settingsProvider(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsProvider(prefs);
}
