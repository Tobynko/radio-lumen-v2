import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_back_button.dart';
import 'package:radio_lumen_v2/features/news/models/news_item.dart';
import 'package:radio_lumen_v2/features/news/providers/news_content_provider.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';
import 'package:html/parser.dart' show parse;

class NewsDetailScreen extends ConsumerWidget {
  const NewsDetailScreen({super.key, required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync = ref.watch(newsContentProvider(item.id));
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.black,
      body: LumenBackground(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                _buildHeaderImage(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        _buildMetaInfo(context),
                        const SizedBox(height: 16),
                        _buildTitle(),
                        const SizedBox(height: 24),
                        const Divider(color: Colors.white10, height: 1),
                        const SizedBox(height: 24),
                        _buildContent(context, contentAsync),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Standardized Glassmorphism Back Button
            Positioned(
              top: topPadding + 8,
              left: 16,
              child: const LumenBackButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (item.imageUrl != null)
                Image.network(
                  item.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholder(),
                )
              else
                _buildPlaceholder(),

              // Refined Gradient Overlay to Background Color
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black26,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black54,
                      Colors.black,
                    ],
                    stops: [0.0, 0.2, 0.6, 0.9, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF2A2A2A),
      child: Center(
        child: Icon(
          Icons.newspaper,
          size: 80,
          color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBorder),
        ),
      ),
    );
  }

  Widget _buildMetaInfo(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.calendar_today_outlined,
          size: 14,
          color: Colors.white70,
        ),
        const SizedBox(width: 6),
        Text(
          DateFormat('d. MMMM yyyy', Localizations.localeOf(context).toString())
              .format(item.date),
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      item.title,
      style: AppTextStyles.headlineLarge.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 30,
        height: 1.15,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildContent(BuildContext context, AsyncValue<String> contentAsync) {
    final l10n = AppLocalizations.of(context)!;
    return contentAsync.when(
      data: (htmlContent) {
        final text = htmlContent.isEmpty ? (item.content ?? '') : htmlContent;
        final document = parse(text);
        final paragraphs =
            document.body?.text
                .trim()
                .split('\n')
                .where((p) => p.trim().isNotEmpty)
                .toList() ??
            [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.author.isNotEmpty) ...[
              Text(
                l10n.newsAuthorLabel(item.author),
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 32),
            ],
            ...paragraphs.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  p.trim(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white.withAlpha(217),
                    height: 1.7,
                    fontSize: 17,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(color: AppColors.accentGold),
        ),
      ),
      error: (error, stack) => Text(
        item.content ?? '',
        style: AppTextStyles.bodyLarge.copyWith(
          color: Colors.white.withAlpha(217),
          height: 1.7,
        ),
      ),
    );
  }
}
