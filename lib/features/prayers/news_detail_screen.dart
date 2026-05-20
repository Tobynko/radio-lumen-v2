import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/features/prayers/models/news_item.dart';
import 'package:radio_lumen_v2/features/prayers/providers/news_content_provider.dart';
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
                        _buildMetaInfo(),
                        const SizedBox(height: 16),
                        _buildTitle(),
                        const SizedBox(height: 24),
                        const Divider(color: Colors.white10, height: 1),
                        const SizedBox(height: 24),
                        _buildContent(contentAsync),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Glassmorphism Back Button
            Positioned(
              top: topPadding + 8,
              left: 16,
              child: _buildGlassBackButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassBackButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.6),
                      Colors.black,
                    ],
                    stops: const [0.0, 0.2, 0.6, 0.9, 1.0],
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
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
    );
  }

  Widget _buildMetaInfo() {
    return Row(
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 14,
          color: Colors.white.withValues(alpha: 0.5),
        ),
        const SizedBox(width: 6),
        Text(
          DateFormat('d. MMMM yyyy', 'sk').format(item.date),
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
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

  Widget _buildContent(AsyncValue<String> contentAsync) {
    return contentAsync.when(
      data: (htmlContent) {
        final text = htmlContent.isEmpty ? (item.content ?? '') : htmlContent;
        final document = parse(text);
        final paragraphs = document.body?.text
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
                'Autor: ${item.author}',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 32),
            ],
            ...paragraphs.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    p.trim(),
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      height: 1.7,
                      fontSize: 17,
                      letterSpacing: 0.2,
                    ),
                  ),
                )),
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
          color: Colors.white.withValues(alpha: 0.85),
          height: 1.7,
        ),
      ),
    );
  }
}
