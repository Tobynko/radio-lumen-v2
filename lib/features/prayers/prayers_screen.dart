import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/features/prayers/models/news_item.dart';
import 'package:radio_lumen_v2/features/prayers/providers/news_provider.dart';
import 'package:radio_lumen_v2/features/prayers/widgets/news_search_bar.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final newsAsync = ref.watch(filteredNewsProvider);
    final currentFilter = ref.watch(newsFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: LumenBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildCategoryFilter(ref, currentFilter, l10n),
              const SizedBox(height: 16),
              Expanded(
                child: newsAsync.when(
                  data: (items) => _buildNewsList(items, l10n),
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentGold,
                    ),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        l10n.archiveError,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: NewsSearchBar(),
    );
  }

  Widget _buildCategoryFilter(
    WidgetRef ref,
    String currentFilter,
    AppLocalizations l10n,
  ) {
    // Stable keys matching the provider logic
    final categories = [
      'Všetky',
      'Novinky',
      'Spravodajstvo',
      'Z nášho vysielania',
    ];

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final categoryKey = categories[index];
          final isSelected = categoryKey == currentFilter;

          // Display name from localization
          String displayName = categoryKey;
          if (categoryKey == 'Všetky') {
            displayName = l10n.newsCategoryAll;
          }
          if (categoryKey == 'Novinky') {
            displayName = l10n.newsCategoryNews;
          }
          if (categoryKey == 'Spravodajstvo') {
            displayName = l10n.newsCategoryReporting;
          }
          if (categoryKey == 'Z nášho vysielania') {
            displayName = l10n.newsCategoryFromBroadcast;
          }

          return GestureDetector(
            onTap: () {
              ref.read(newsFilterProvider.notifier).setFilter(categoryKey);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accentGold
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentGold
                      : Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.accentGold.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  displayName.toUpperCase(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.85),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsList(List<NewsItem> items, AppLocalizations l10n) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          l10n.newsNoItems,
          style: const TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.push('/aktuality/detail', extra: item);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                if (item.imageUrl != null)
                  Image.network(
                    item.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),

                // Gradient overlay to ensure text readability
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.7),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
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
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.author,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('d. M.').format(item.date),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
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
