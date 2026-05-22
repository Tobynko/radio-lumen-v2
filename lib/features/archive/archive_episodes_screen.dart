// Path: lib/features/archive/archive_episodes_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_back_button.dart';
import 'package:radio_lumen_v2/features/archive/models/archive_episode.dart';
import 'package:radio_lumen_v2/features/archive/models/archive_program.dart';

class ArchiveEpisodesScreen extends ConsumerWidget {
  final ArchiveProgram program;

  const ArchiveEpisodesScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          program.name,
          style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(
            child: LumenBackButton(
              onTap: () => context.pop(),
              size: 18,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: LumenBackground(
        child: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignTokens.screenPadding,
              vertical: AppDesignTokens.spacingXXL,
            ),
            itemCount: program.episodes.length,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDesignTokens.spacingM),
              child: Divider(
                color: Colors.white.withAlpha(AppDesignTokens.alphaDivider),
                height: 1,
              ),
            ),
            itemBuilder: (context, index) {
              final episode = program.episodes[index];
              final dateStr = DateFormat('d.M.yy').format(episode.pubDate);
              final timeStr = DateFormat('HH:mm').format(episode.pubDate);

              return InkWell(
                onTap: () {
                  context.push(
                    '/archive-player',
                    extra: episode.toScheduleItem(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppDesignTokens.spacingS),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date/Time Column - Standardized to listItemTime/listItemSubtitle
                      SizedBox(
                        width: 65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dateStr,
                              style: AppTextStyles.listItemTime.copyWith(
                                color: AppColors.accentGold,
                              ),
                            ),
                            Text(
                              timeStr,
                              style: AppTextStyles.listItemSubtitle.copyWith(
                                color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
                                fontSize: 16, // Slightly larger for time subtext
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDesignTokens.spacingM),
                      // Episode Title - Standardized to listItemTitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              episode.title,
                              style: AppTextStyles.listItemTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (episode.description.isNotEmpty) ...[
                              const SizedBox(height: AppDesignTokens.spacingXS),
                              Text(
                                episode.description,
                                style: AppTextStyles.listItemSubtitle.copyWith(
                                  color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.play_circle_fill),
                        color: AppColors.accentGold,
                        iconSize: 36,
                        onPressed: () {
                          context.push(
                            '/archive-player',
                            extra: episode.toScheduleItem(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
