// Path: lib/features/news/news_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_search_bar.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_filter_bar.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_loading_view.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_error_view.dart';
import 'package:radio_lumen_v2/features/news/models/news_item.dart';
import 'package:radio_lumen_v2/features/news/providers/news_provider.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final newsAsync = ref.watch(filteredNewsProvider);
    final currentFilter = ref.watch(newsFilterProvider);
    final searchQuery = ref.watch(newsSearchQueryProvider);

    return Scaffold(
      body: LumenBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Category Tabs at the top for better hierarchy and consistency
              _buildCategoryFilter(ref, currentFilter, l10n),
              
              // 2. Search Bar below categories
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDesignTokens.screenPadding,
                  AppDesignTokens.spacingM, // Reduced spacing between tabs and search
                  AppDesignTokens.screenPadding,
                  AppDesignTokens.spacingS, // Small gap before the news list
                ),
                child: LumenSearchBar(
                  hintText: l10n.newsSearchHint,
                  controller: TextEditingController(text: searchQuery)
                    ..selection = TextSelection.fromPosition(
                      TextPosition(offset: searchQuery.length),
                    ),
                  onChanged: (value) {
                    ref.read(newsSearchQueryProvider.notifier).setQuery(value);
                  },
                  onClear: () {
                    ref.read(newsSearchQueryProvider.notifier).setQuery('');
                  },
                ),
              ),

              // 3. News List
              Expanded(
                child: newsAsync.when(
                  data: (items) => _buildNewsList(items, l10n),
                  loading: () => const LumenLoadingView(),
                  // Pattern: Removed manual retry button to favor automatic refresh via provider logic
                  error: (error, stackTrace) => LumenErrorView(
                    message: l10n.newsError,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(
    WidgetRef ref,
    String currentFilter,
    AppLocalizations l10n,
  ) {
    final categories = [
      'Všetky',
      'Novinky',
      'Spravodajstvo',
      'Z nášho vysielania',
    ];

    return Padding(
      padding: const EdgeInsets.only(top: AppDesignTokens.spacingL),
      child: LumenFilterBar<String>(
        items: categories,
        selectedItem: currentFilter,
        onSelected: (categoryKey) {
          ref.read(newsFilterProvider.notifier).setFilter(categoryKey);
        },
        labelBuilder: (categoryKey) {
          if (categoryKey == 'Všetky') return l10n.newsCategoryAll;
          if (categoryKey == 'Novinky') return l10n.newsCategoryNews;
          if (categoryKey == 'Spravodajstvo') return l10n.newsCategoryReporting;
          if (categoryKey == 'Z nášho vysielania') {
            return l10n.newsCategoryFromBroadcast;
          }
          return categoryKey;
        },
        height: 48,
      ),
    );
  }

  Widget _buildNewsList(List<NewsItem> items, AppLocalizations l10n) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          l10n.newsNoItems,
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        left: AppDesignTokens.contentPadding,
        right: AppDesignTokens.contentPadding,
        top: AppDesignTokens.spacingS,
        bottom: AppDesignTokens.spacingL,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _NewsCard(item: items[index]);
      },
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.75,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spacingS,
        vertical: AppDesignTokens.spacingM,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBackground),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusXXL),
        boxShadow: AppDesignTokens.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusXXL),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.push('/aktuality/detail', extra: item);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (item.imageUrl != null)
                  Image.network(
                    item.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(
                          AppDesignTokens.alphaGlassBorder,
                        ),
                        Colors.black.withAlpha(AppDesignTokens.alphaDivider),
                        Colors.black.withAlpha(
                          AppDesignTokens.alphaTextSecondary + 50,
                        ),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppDesignTokens.spacingXXL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        item.title,
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          height: 1.1,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            const Shadow(
                              color: Colors.black,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppDesignTokens.spacingM),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.author,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white.withAlpha(
                                  AppDesignTokens.alphaTextSecondary + 50,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: AppDesignTokens.spacingS),
                          Text(
                            DateFormat('d. M.').format(item.date),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white.withAlpha(
                                  AppDesignTokens.alphaTextSecondary + 50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
