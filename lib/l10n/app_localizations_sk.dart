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
  String get homeTitle => 'Domov';

  @override
  String get playerTitle => 'Prehrávač';

  @override
  String get scheduleTitle => 'Program';

  @override
  String get navLive => 'Naživo';

  @override
  String get navProgram => 'Program';

  @override
  String get navArchiv => 'Archív';

  @override
  String get navAktuality => 'Aktuality';

  @override
  String get navHome => 'Naživo';

  @override
  String get qualityTitle => 'KVALITA PRENOSU';

  @override
  String get qualityHigh => 'Vysoká kvalita (odporúčané pre Wi-Fi)';

  @override
  String get qualityMedium => 'Stredná kvalita';

  @override
  String get qualityLow => 'Nízka kvalita (šetrí dáta)';

  @override
  String get scheduleTabProgram => 'Program';

  @override
  String get scheduleTabPlaylists => 'Playlisty';

  @override
  String get scheduleTabShows => 'Relácie';

  @override
  String get scheduleNoItems => 'Na tento deň nie je dostupný program.';

  @override
  String get tagSpiritual => 'Duchovné slovo';

  @override
  String get tagLive => 'Naživo';

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
}
