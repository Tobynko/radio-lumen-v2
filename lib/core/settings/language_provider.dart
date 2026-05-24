import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'shared_preferences_provider.dart';

part 'language_provider.g.dart';

@riverpod
class Language extends _$Language {
  static const _key = 'app_language';

  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedCode = prefs.getString(_key);
    
    if (savedCode != null) {
      return Locale(savedCode);
    }
    
    // Default to Slovak
    return const Locale('sk');
  }

  Future<void> setLanguage(String code) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_key, code);
    state = Locale(code);
  }
}
