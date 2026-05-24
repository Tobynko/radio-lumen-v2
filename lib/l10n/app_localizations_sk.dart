// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'Rádio LUMEN';

  @override
  String get navLive => 'Naživo';

  @override
  String get navProgram => 'Program';

  @override
  String get navArchiv => 'Archív';

  @override
  String get navAktuality => 'Aktuality';

  @override
  String get qualityTitle => 'KVALITA PRENOSU';

  @override
  String get qualityHigh => 'Vysoká kvalita (odporúčané pre Wi-Fi)';

  @override
  String get qualityMedium => 'Stredná kvalita';

  @override
  String get qualityLow => 'Nízka kvalita (šetrí dáta)';

  @override
  String get scheduleNoItems => 'Na tento deň nie je dostupný program.';

  @override
  String get archiveSearchHint => 'Hľadať v archíve...';

  @override
  String get archiveNoResults => 'Nenašli sa žiadne výsledky.';

  @override
  String get archiveError => 'Nastala chyba pri načítavaní archívu.';

  @override
  String archiveEpisodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count epizód',
      few: '$count epizódy',
      one: '1 epizóda',
    );
    return '$_temp0';
  }

  @override
  String get newsCategoryAll => 'Všetky';

  @override
  String get newsCategoryFromBroadcast => 'Z nášho vysielania';

  @override
  String get newsCategoryNews => 'Novinky';

  @override
  String get newsCategoryReporting => 'Spravodajstvo';

  @override
  String get newsNoItems => 'Žiadne aktuality v tejto kategórii.';

  @override
  String get newsSearchHint => 'Hľadať v aktualitách...';

  @override
  String get newsError => 'Nastala chyba pri načítavaní aktualít.';

  @override
  String get connectivityOffline => 'Chýba internetové pripojenie';

  @override
  String get audioLiveTitle => 'Naživo';

  @override
  String get audioStationName => 'Rádio LUMEN';

  @override
  String get audioArchiveAlbum => 'Rádio LUMEN Archív';

  @override
  String shareTextWithArtist(String title, String artist) {
    return 'Práve počúvam $title od $artist na Rádiu LUMEN! 🎧 https://www.lumen.sk';
  }

  @override
  String shareTextTitleOnly(String title) {
    return 'Práve počúvam $title na Rádiu LUMEN! 🎧 https://www.lumen.sk';
  }

  @override
  String newsAuthorLabel(String author) {
    return 'Autor: $author';
  }

  @override
  String get tagSpiritual => 'Duchovné slovo';

  @override
  String get tagLive => 'Naživo';

  @override
  String get scheduleError => 'Nastala chyba pri načítavaní programu.';

  @override
  String get aboutTitle => 'O aplikácii';

  @override
  String aboutVersion(String version) {
    return 'Verzia $version';
  }

  @override
  String get aboutPrivacyPolicy => 'Ochrana osobných údajov';

  @override
  String get aboutLumenClub => 'LUMEN Klub';

  @override
  String get aboutContactUs => 'Kontaktujte nás';

  @override
  String get aboutDevelopedBy => 'Aplikáciu vyvinuli';

  @override
  String get aboutCopyright => '© 2026 Rádio LUMEN. Všetky práva vyhradené.';

  @override
  String get aboutLanguage => 'Jazyk';

  @override
  String get quoteTitle => 'Citát dňa';

  @override
  String get quoteError => 'Nepodarilo sa načítať citát.';
}
