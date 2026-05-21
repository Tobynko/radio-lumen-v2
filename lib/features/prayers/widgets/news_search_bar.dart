import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/features/prayers/providers/news_provider.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

class NewsSearchBar extends ConsumerStatefulWidget {
  const NewsSearchBar({super.key});

  @override
  ConsumerState<NewsSearchBar> createState() => _NewsSearchBarState();
}

class _NewsSearchBarState extends ConsumerState<NewsSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final currentQuery = ref.read(newsSearchQueryProvider);
    _controller = TextEditingController(text: currentQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withAlpha(25)),
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          ref.read(newsSearchQueryProvider.notifier).setQuery(value);
        },
        style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
        cursorColor: AppColors.accentGold,
        decoration: InputDecoration(
          hintText: l10n.newsSearchHint,
          hintStyle: AppTextStyles.bodyLarge.copyWith(
            color: Colors.white.withAlpha(128),
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white70),
                  onPressed: () {
                    _controller.clear();
                    ref.read(newsSearchQueryProvider.notifier).setQuery('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
