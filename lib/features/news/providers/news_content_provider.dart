import 'package:html/parser.dart' show parse;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:radio_lumen_v2/core/network/dio_provider.dart';

part 'news_content_provider.g.dart';

@riverpod
Future<String> newsContent(Ref ref, String link) async {
  final dio = ref.watch(dioClientProvider);

  // link is expected to be a full URL from the news scraper
  // If it's relative, we should prepand the base URL
  String fullUrl = link;
  if (!link.startsWith('http')) {
    fullUrl = 'https://www.lumen.sk/$link';
  }

  try {
    final response = await dio.get(fullUrl);
    final document = parse(response.data);

    // Based on actual HTML inspection, the content is in div.wysiwyg
    final contentElement = document.querySelector('div.wysiwyg');

    if (contentElement == null) {
      // Fallback to text-content if wysiwyg is not found
      final fallbackElement = document.querySelector('div.text-content');
      if (fallbackElement == null) return '';
      return fallbackElement.innerHtml.trim();
    }

    return contentElement.innerHtml.trim();
  } catch (e) {
    rethrow;
  }
}
