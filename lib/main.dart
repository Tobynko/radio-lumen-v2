import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_lumen_v2/core/audio/audio_handler.dart';
import 'package:radio_lumen_v2/core/settings/shared_preferences_provider.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';
import 'package:radio_lumen_v2/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

late AudioHandler audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  audioHandler = await AudioService.init(
    builder: () => LumenAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'sk.lumen.radio.channel.audio',
      androidNotificationChannelName: 'Radio LUMEN Playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rádio LUMEN',
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF232D69), // AppColors.primary
        ),
        useMaterial3: true,
      ),
    );
  }
}
