// Path: lib/features/home/providers/quotes_provider.dart
import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:radio_lumen_v2/core/network/dio_provider.dart';
import 'package:radio_lumen_v2/core/network/connectivity_provider.dart';
import 'package:radio_lumen_v2/core/settings/language_provider.dart';
import '../models/quote_item.dart';

part 'quotes_provider.g.dart';

@riverpod
class Quotes extends _$Quotes {
  @override
  Future<QuoteItem> build() async {
    // Watch connectivity to auto-retry when back online
    ref.watch(isOfflineProvider);
    
    // Watch language to automatically switch translation when app language changes
    final locale = ref.watch(languageProvider);
    
    return _fetchRandomVerse(locale.languageCode);
  }

  Future<QuoteItem> _fetchRandomVerse(String languageCode) async {
    final dio = ref.read(dioClientProvider);
    final random = Random();

    // Map app language to Bible translation ID
    String translationId = 'slk_bib'; // Default to Slovak
    if (languageCode == 'en') {
      translationId = 'eng_bsb'; // Berean Standard Bible
    } else if (languageCode == 'hu') {
      translationId = 'hun_bib'; // Hungarian Open New Testament
    }

    try {
      // 1. Fetch available books for the selected translation
      final booksResponse = await dio.get(
        'https://bible.helloao.org/api/$translationId/books.json',
      );
      
      final List<dynamic> books = booksResponse.data['books'];
      final randomBook = books[random.nextInt(books.length)];
      final String bookId = randomBook['id'];
      final String bookName = randomBook['name'];
      final int chapterCount = randomBook['numberOfChapters'] ?? 1;

      // 2. Pick a random chapter
      final int randomChapter = random.nextInt(chapterCount) + 1;

      // 3. Fetch the specific chapter
      final chapterResponse = await dio.get(
        'https://bible.helloao.org/api/$translationId/$bookId/$randomChapter.json',
      );

      final List<dynamic> content = chapterResponse.data['chapter']['content'];
      
      // Filter for actual verse items
      final List<dynamic> actualVerses = content.where((v) => v['type'] == 'verse').toList();
      
      if (actualVerses.isEmpty) {
        throw Exception('No verses found in chapter');
      }

      final randomVerse = actualVerses[random.nextInt(actualVerses.length)];
      
      // Robust content extraction
      String verseText = '';
      final verseContent = randomVerse['content'];
      
      if (verseContent is List) {
        for (var part in verseContent) {
          if (part is Map) {
            verseText += part['text']?.toString() ?? '';
          } else if (part is String) {
            verseText += part;
          }
        }
      } else if (verseContent != null) {
        verseText = verseContent.toString();
      }

      if (verseText.trim().isEmpty) {
        throw Exception('Verse text is empty');
      }

      return QuoteItem(
        text: verseText.trim(),
        author: bookName,
        reference: "$bookName $randomChapter:${randomVerse['number']}",
      );
    } catch (e) {
      // Re-throw so standard ErrorView handles it
      rethrow;
    }
  }

  Future<void> nextQuote() async {
    final languageCode = ref.read(languageProvider).languageCode;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchRandomVerse(languageCode));
  }
}
