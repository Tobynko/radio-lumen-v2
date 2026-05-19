// Path: lib/features/archive/archive_episodes_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: LumenBackground(
        child: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            itemCount: program.episodes.length,
            separatorBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    color: Colors.white.withAlpha(38),
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
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date/Time Column
                      SizedBox(
                        width: 65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dateStr,
                              style: AppTextStyles.titleLarge.copyWith(
                                color: AppColors.accentGold,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              timeStr,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white.withAlpha(178),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Episode Title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              episode.title,
                              style: AppTextStyles.titleLarge.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (episode.description.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                episode.description,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white.withAlpha(153),
                                  fontSize: 14,
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
