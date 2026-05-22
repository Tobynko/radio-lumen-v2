import 'package:html/parser.dart' show parse;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:radio_lumen_v2/features/news/models/news_item.dart';
import 'package:radio_lumen_v2/core/network/dio_provider.dart';
import 'package:radio_lumen_v2/core/utils/string_utils.dart';
import 'package:intl/intl.dart';

part 'news_provider.g.dart';

@riverpod
class NewsFilter extends _$NewsFilter {
  @override
  String build() => 'Všetky';

  void setFilter(String category) {
    state = category;
  }
}

@riverpod
class NewsSearchQuery extends _$NewsSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
Future<List<NewsItem>> news(Ref ref) async {
  final dio = ref.watch(dioClientProvider);
  final currentFilter = ref.watch(newsFilterProvider);

  String url = 'https://www.lumen.sk/aktuality.html';
  if (currentFilter == 'Z nášho vysielania') {
    url = 'https://www.lumen.sk/aktuality/z-nasho-vysielania.html';
  } else if (currentFilter == 'Novinky') {
    url = 'https://www.lumen.sk/aktuality/novinky.html';
  } else if (currentFilter == 'Spravodajstvo') {
    url = 'https://www.lumen.sk/aktuality/spravodajstvo.html';
  }

  try {
    final response = await dio.get(url);
    final document = parse(response.data);

    // The structure based on inspection:
    // a.news__item.indetail is the container
    final itemElements = document.querySelectorAll('a.news__item.indetail');

    final List<NewsItem> items = [];

    for (final element in itemElements) {
      final title =
          element.querySelector('.news__item__title')?.text.trim() ?? '';

      // Extract image URL from background-image style
      final imgWrap = element.querySelector('.imgwrap');
      String? imageUrl;
      if (imgWrap != null) {
        final style = imgWrap.attributes['style'] ?? '';
        final match = RegExp(r"url\('(.+?)'\)").firstMatch(style);
        if (match != null) {
          imageUrl = match.group(1);
        }
      }

      // Extract date and author
      // <div class="news__item__date"> 20.05.2026 <strong>Kathpress.at</strong> </div>
      final dateContainer = element.querySelector('.news__item__date');
      String author = '';
      DateTime date = DateTime.now();

      if (dateContainer != null) {
        final authorElement = dateContainer.querySelector('strong');
        author = authorElement?.text.trim() ?? '';

        // Remove author text from container to get the date string
        String dateText = dateContainer.text.replaceAll(author, '').trim();
        try {
          // Date format on site is usually DD.MM.YYYY
          date = DateFormat('dd.MM.yyyy').parse(dateText);
        } catch (_) {
          // Fallback if parsing fails
        }
      }

      final perex = element.querySelector('p')?.text.trim() ?? '';
      final link = element.attributes['href'] ?? '';

      items.add(
        NewsItem(
          id: link,
          title: title,
          author: author,
          date: date,
          category: currentFilter,
          imageUrl: imageUrl,
          content: perex,
        ),
      );
    }

    return items;
  } catch (e) {
    // Return empty list or throw to handle in UI
    rethrow;
  }
}

@riverpod
Future<List<NewsItem>> filteredNews(Ref ref) async {
  final news = await ref.watch(newsProvider.future);
  final query = StringUtils.normalizeForSearch(ref.watch(newsSearchQueryProvider));

  if (query.isEmpty) return news;

  return news
      .where(
        (item) =>
            StringUtils.normalizeForSearch(item.title).contains(query) ||
            StringUtils.normalizeForSearch(item.author).contains(query) ||
            (item.content != null &&
                StringUtils.normalizeForSearch(item.content!).contains(query)),
      )
      .toList();
}
