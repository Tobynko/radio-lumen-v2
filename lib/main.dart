import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_lumen_v2/core/audio/audio_handler.dart';
import 'package:radio_lumen_v2/core/settings/language_provider.dart';
import 'package:radio_lumen_v2/core/settings/shared_preferences_provider.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/utils/l10n_utils.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';
import 'package:radio_lumen_v2/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

late AudioHandler audioHandler;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final prefs = await SharedPreferences.getInstance();

  audioHandler = await AudioService.init(
    builder: () => LumenAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'sk.lumen.radio.channel.audio',
      androidNotificationChannelName: 'Radio LUMEN Playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidNotificationIcon: 'mipmap/launcher_icon',
    ),
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );

  FlutterNativeSplash.remove();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize L10n utility to allow context-free access to localized strings
    L10n.init(context);

    final currentLocale = ref.watch(languageProvider);

    return MaterialApp.router(
      title: 'Rádio LUMEN',
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      locale: currentLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accentGold,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.backgroundMain,
        useMaterial3: true,
        dividerTheme: DividerThemeData(
          color: Colors.white.withValues(alpha: 0.15),
          thickness: 1,
          space: 1,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentGold,
            foregroundColor: AppColors.primary,
            textStyle: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignTokens.spacingXL,
              vertical: AppDesignTokens.spacingM,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDesignTokens.buttonRadius),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: AppTextStyles.bodyMedium,
          ),
        ),
      ),
    );
  }
}
