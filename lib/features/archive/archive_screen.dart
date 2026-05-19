// Path: lib/features/archive/archive_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/features/archive/providers/archive_provider.dart';
import 'package:radio_lumen_v2/features/archive/widgets/archive_search_bar.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final archiveAsync = ref.watch(filteredArchiveProgramsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: LumenBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: ArchiveSearchBar(),
              ),
              Expanded(
                child: archiveAsync.when(
                  data: (programs) => _buildProgramList(context, programs),
                  loading:
                      () => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accentGold,
                        ),
                      ),
                  error:
                      (error, stackTrace) => Center(
                        child: Text(
                          l10n.archiveError,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.white,
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

  Widget _buildProgramList(
    BuildContext context,
    List<dynamic> programs, // Using dynamic to avoid import issues for now
  ) {
    final l10n = AppLocalizations.of(context)!;

    if (programs.isEmpty) {
      return Center(
        child: Text(
          l10n.archiveNoResults,
          style: const TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: programs.length,
      itemBuilder: (context, index) {
        final program = programs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withAlpha(25)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            title: Text(
              program.name,
              style: AppTextStyles.titleLarge.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              l10n.archiveEpisodesCount(program.episodes.length),
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white.withAlpha(153),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 16,
            ),
            onTap: () {
              context.push('/archiv/episodes', extra: program);
            },
          ),
        );
      },
    );
  }
}
