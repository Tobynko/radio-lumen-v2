import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_sk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('sk')];

  /// The title of the application
  ///
  /// In sk, this message translates to:
  /// **'Rádio LUMEN'**
  String get appTitle;

  /// Title for the Home screen
  ///
  /// In sk, this message translates to:
  /// **'Domov'**
  String get homeTitle;

  /// Title for the Live Player screen
  ///
  /// In sk, this message translates to:
  /// **'Prehrávač'**
  String get playerTitle;

  /// Title for the Schedule screen
  ///
  /// In sk, this message translates to:
  /// **'Program'**
  String get scheduleTitle;

  /// Label for Live tab
  ///
  /// In sk, this message translates to:
  /// **'Naživo'**
  String get navLive;

  /// Label for Program tab
  ///
  /// In sk, this message translates to:
  /// **'Program'**
  String get navProgram;

  /// Label for Archiv tab
  ///
  /// In sk, this message translates to:
  /// **'Archív'**
  String get navArchiv;

  /// Label for Aktuality tab (formerly Modlitby)
  ///
  /// In sk, this message translates to:
  /// **'Aktuality'**
  String get navAktuality;

  /// Label for Home tab
  ///
  /// In sk, this message translates to:
  /// **'Naživo'**
  String get navHome;

  /// Title for the quality picker bottom sheet
  ///
  /// In sk, this message translates to:
  /// **'KVALITA PRENOSU'**
  String get qualityTitle;

  /// Description for 128kbps quality
  ///
  /// In sk, this message translates to:
  /// **'Vysoká kvalita (odporúčané pre Wi-Fi)'**
  String get qualityHigh;

  /// Description for 64kbps quality
  ///
  /// In sk, this message translates to:
  /// **'Stredná kvalita'**
  String get qualityMedium;

  /// Description for 32kbps quality
  ///
  /// In sk, this message translates to:
  /// **'Nízka kvalita (šetrí dáta)'**
  String get qualityLow;

  /// Tab label for Program
  ///
  /// In sk, this message translates to:
  /// **'Program'**
  String get scheduleTabProgram;

  /// Tab label for Playlists
  ///
  /// In sk, this message translates to:
  /// **'Playlisty'**
  String get scheduleTabPlaylists;

  /// Tab label for Shows/Relacie
  ///
  /// In sk, this message translates to:
  /// **'Relácie'**
  String get scheduleTabShows;

  /// Message shown when no schedule items are available for a selected day
  ///
  /// In sk, this message translates to:
  /// **'Na tento deň nie je dostupný program.'**
  String get scheduleNoItems;

  /// Tag label for spiritual content
  ///
  /// In sk, this message translates to:
  /// **'Duchovné slovo'**
  String get tagSpiritual;

  /// Tag label for live broadcast
  ///
  /// In sk, this message translates to:
  /// **'Naživo'**
  String get tagLive;

  /// Hint text for archive search bar
  ///
  /// In sk, this message translates to:
  /// **'Hľadať v archíve...'**
  String get archiveSearchHint;

  /// Message shown when no search results are found in archive
  ///
  /// In sk, this message translates to:
  /// **'Nenašli sa žiadne výsledky.'**
  String get archiveNoResults;

  /// Error message when archive fails to load
  ///
  /// In sk, this message translates to:
  /// **'Nastala chyba pri načítavaní archívu.'**
  String get archiveError;

  /// Pluralized count of episodes
  ///
  /// In sk, this message translates to:
  /// **'{count, plural, one{1 epizóda} few{{count} epizódy} other{{count} epizód}}'**
  String archiveEpisodesCount(int count);

  /// Category label for all news
  ///
  /// In sk, this message translates to:
  /// **'Všetky'**
  String get newsCategoryAll;

  /// Category label for news from broadcast
  ///
  /// In sk, this message translates to:
  /// **'Z nášho vysielania'**
  String get newsCategoryFromBroadcast;

  /// Category label for general news
  ///
  /// In sk, this message translates to:
  /// **'Novinky'**
  String get newsCategoryNews;

  /// Category label for reporting news
  ///
  /// In sk, this message translates to:
  /// **'Spravodajstvo'**
  String get newsCategoryReporting;

  /// Message shown when no news items are available
  ///
  /// In sk, this message translates to:
  /// **'Žiadne aktuality v tejto kategórii.'**
  String get newsNoItems;

  /// Hint text for news search bar
  ///
  /// In sk, this message translates to:
  /// **'Hľadať v aktualitách...'**
  String get newsSearchHint;

  /// Message shown when there is no internet connection
  ///
  /// In sk, this message translates to:
  /// **'Chýba internetové pripojenie'**
  String get connectivityOffline;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['sk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'sk':
      return AppLocalizationsSk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
