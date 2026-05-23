// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Radio LUMEN';

  @override
  String get navLive => 'Live';

  @override
  String get navProgram => 'Schedule';

  @override
  String get navArchiv => 'Archive';

  @override
  String get navAktuality => 'News';

  @override
  String get qualityTitle => 'STREAM QUALITY';

  @override
  String get qualityHigh => 'High quality (recommended for Wi-Fi)';

  @override
  String get qualityMedium => 'Medium quality';

  @override
  String get qualityLow => 'Low quality (saves data)';

  @override
  String get scheduleNoItems => 'No program available for this day.';

  @override
  String get archiveSearchHint => 'Search in archive...';

  @override
  String get archiveNoResults => 'No results found.';

  @override
  String get archiveError => 'An error occurred while loading the archive.';

  @override
  String archiveEpisodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count episodes',
      one: '1 episode',
    );
    return '$_temp0';
  }

  @override
  String get newsCategoryAll => 'All';

  @override
  String get newsCategoryFromBroadcast => 'From our broadcast';

  @override
  String get newsCategoryNews => 'News';

  @override
  String get newsCategoryReporting => 'Reporting';

  @override
  String get newsNoItems => 'No news items in this category.';

  @override
  String get newsSearchHint => 'Search in news...';

  @override
  String get newsError => 'An error occurred while loading news.';

  @override
  String get connectivityOffline => 'No internet connection';

  @override
  String get audioLiveTitle => 'Live';

  @override
  String get audioStationName => 'Radio LUMEN';

  @override
  String get audioArchiveAlbum => 'Radio LUMEN Archive';

  @override
  String shareTextWithArtist(String title, String artist) {
    return 'I\'m listening to $title by $artist on Radio LUMEN! 🎧 https://www.lumen.sk';
  }

  @override
  String shareTextTitleOnly(String title) {
    return 'I\'m listening to $title on Radio LUMEN! 🎧 https://www.lumen.sk';
  }

  @override
  String newsAuthorLabel(String author) {
    return 'Author: $author';
  }

  @override
  String get tagSpiritual => 'Spiritual word';

  @override
  String get tagLive => 'Live';

  @override
  String get scheduleError => 'An error occurred while loading the schedule.';

  @override
  String get aboutTitle => 'About application';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get aboutPrivacyPolicy => 'Privacy Policy';

  @override
  String get aboutLumenClub => 'LUMEN Club';

  @override
  String get aboutContactUs => 'Contact us';

  @override
  String get aboutDevelopedBy => 'Developed by';

  @override
  String get aboutCopyright => '© 2026 Radio LUMEN. All rights reserved.';

  @override
  String get aboutLanguage => 'Language';

  @override
  String get quoteTitle => 'Daily Wisdom';

  @override
  String get quoteError => 'Failed to load quote.';
}
