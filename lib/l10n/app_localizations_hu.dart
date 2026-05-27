// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'LUMEN Rádió';

  @override
  String get navLive => 'Élő';

  @override
  String get navProgram => 'Műsor';

  @override
  String get navArchiv => 'Archívum';

  @override
  String get navAktuality => 'Hírek';

  @override
  String get qualityTitle => 'ADÁSI MINŐSÉG';

  @override
  String get qualityHigh => 'Magas minőség (Wi-Fi ajánlott)';

  @override
  String get qualityMedium => 'Közepes minőség';

  @override
  String get qualityLow => 'Alacsony minőség (adatkímélő)';

  @override
  String get scheduleNoItems => 'Erre a napra nincs elérhető műsor.';

  @override
  String get archiveSearchHint => 'Keresés az archívumban...';

  @override
  String get archiveNoResults => 'Nincs találat.';

  @override
  String get archiveError => 'Hiba történt az archívum betöltésekor.';

  @override
  String archiveEpisodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count adás',
      one: '1 adás',
    );
    return '$_temp0';
  }

  @override
  String get newsCategoryAll => 'Mind';

  @override
  String get newsCategoryFromBroadcast => 'Adásunkból';

  @override
  String get newsCategoryNews => 'Hírek';

  @override
  String get newsCategoryReporting => 'Tudósítások';

  @override
  String get newsNoItems => 'Ebben a kategóriában nincsenek hírek.';

  @override
  String get newsSearchHint => 'Keresés a hírekben...';

  @override
  String get newsError => 'Hiba történt a hírek betöltésekor.';

  @override
  String get connectivityOffline => 'Nincs internetkapcsolat';

  @override
  String get audioLiveTitle => 'Élő';

  @override
  String get audioStationName => 'LUMEN Rádió';

  @override
  String get audioArchiveAlbum => 'LUMEN Rádió Archívum';

  @override
  String shareTextWithArtist(String title, String artist) {
    return 'Épp a(z) $title-t hallgatom $artist-tól a LUMEN Rádión! 🎧 https://www.lumen.sk';
  }

  @override
  String shareTextTitleOnly(String title) {
    return 'Épp a(z) $title-t hallgatom a LUMEN Rádión! 🎧 https://www.lumen.sk';
  }

  @override
  String newsAuthorLabel(String author) {
    return 'Szerző: $author';
  }

  @override
  String get tagSpiritual => 'Lelki szó';

  @override
  String get tagLive => 'Élő';

  @override
  String get scheduleError => 'Hiba történt a műsorrend betöltésekor.';

  @override
  String get aboutTitle => 'Az alkalmazásról';

  @override
  String aboutVersion(String version) {
    return 'Verzió $version';
  }

  @override
  String get aboutPrivacyPolicy => 'Adatvédelmi irányelvek';

  @override
  String get aboutLumenClub => 'LUMEN Klub';

  @override
  String get aboutContactUs => 'Kapcsolat';

  @override
  String get aboutDevelopedBy => 'Az alkalmazást készítették';

  @override
  String get aboutCopyright => '© 2026 LUMEN Rádió. Minden jog fenntartva.';

  @override
  String get aboutLanguage => 'Nyelv';

  @override
  String get quoteTitle => 'A nap idézete';

  @override
  String get quoteError => 'Nem sikerült betölteni az idézetet.';
}
