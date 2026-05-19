// Path: lib/features/archive/providers/archive_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:radio_lumen_v2/core/network/dio_provider.dart';
import 'package:radio_lumen_v2/core/utils/string_utils.dart';
import 'package:radio_lumen_v2/features/archive/models/archive_episode.dart';
import 'package:radio_lumen_v2/features/archive/models/archive_program.dart';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

part 'archive_provider.g.dart';

@riverpod
Future<List<ArchiveProgram>> archivePrograms(Ref ref) async {
  final dioClient = ref.watch(dioClientProvider);
  final xmlString = await dioClient.fetchArchiveXml();

  final document = XmlDocument.parse(xmlString);
  final items = document.findAllElements('item');

  final episodes = <ArchiveEpisode>[];

  for (final item in items) {
    final originalTitle =
        item.findElements('title').firstOrNull?.innerText ?? '';
    final description =
        item.findElements('description').firstOrNull?.innerText ?? '';
    final pubDateStr =
        item.findElements('pubDate').firstOrNull?.innerText ?? '';
    final enclosure = item.findElements('enclosure').firstOrNull;
    final audioUrl = enclosure?.getAttribute('url') ?? '';

    if (audioUrl.isEmpty) continue;

    final pubDate = _parseRssDate(pubDateStr);
    final programName = _normalizeTitle(originalTitle);

    episodes.add(
      ArchiveEpisode(
        title: originalTitle,
        originalTitle: originalTitle,
        pubDate: pubDate,
        description: description.trim(),
        audioUrl: audioUrl,
        programName: programName,
      ),
    );
  }

  // Group by program name
  final grouped = <String, List<ArchiveEpisode>>{};
  for (final episode in episodes) {
    grouped.putIfAbsent(episode.programName, () => []).add(episode);
  }

  final programs =
      grouped.entries.map((e) {
        // Sort episodes newest first
        final sortedEpisodes =
            e.value..sort((a, b) => b.pubDate.compareTo(a.pubDate));
        return ArchiveProgram(name: e.key, episodes: sortedEpisodes);
      }).toList();

  // Sort programs alphabetically
  programs.sort((a, b) => a.name.compareTo(b.name));

  return programs;
}

@riverpod
class ArchiveSearchQuery extends _$ArchiveSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
Future<List<ArchiveProgram>> filteredArchivePrograms(Ref ref) async {
  final programs = await ref.watch(archiveProgramsProvider.future);
  final query = StringUtils.normalizeForSearch(ref.watch(archiveSearchQueryProvider));

  if (query.isEmpty) return programs;

  return programs.where((program) {
    // Search in program name
    if (StringUtils.normalizeForSearch(program.name).contains(query)) {
      return true;
    }

    // Search in episode titles or descriptions
    return program.episodes.any(
      (episode) =>
          StringUtils.normalizeForSearch(episode.title).contains(query) ||
          StringUtils.normalizeForSearch(episode.description).contains(query),
    );
  }).toList();
}

DateTime _parseRssDate(String dateStr) {
  try {
    // RSS date format: Tue, 19 May 2026 07:20:00 +0200
    // Using en_US locale for English day and month names
    return DateFormat('EEE, dd MMM yyyy HH:mm:ss Z', 'en_US').parse(dateStr);
  } catch (e) {
    // Fallback to basic parsing if DateFormat fails
    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      return DateTime.now();
    }
  }
}

String _normalizeTitle(String originalTitle) {
  // Pattern to match time and date at the end of the title
  // Example: "Kalendár prírody 07:20 19.05.2026"
  // Example: "Emauzy - sv. omša 08:30 08:30 19.05.2026"
  final regex = RegExp(
    r'\s+\d{1,2}:\d{2}(?:\s+\d{1,2}:\d{2})?\s+\d{1,2}\.\d{1,2}\.\d{4}$',
  );
  return originalTitle.replaceFirst(regex, '').trim();
}
