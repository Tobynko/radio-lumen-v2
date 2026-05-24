// Path: lib/features/archive/archive_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_list_item.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_search_bar.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_loading_view.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_error_view.dart';
import 'package:radio_lumen_v2/features/archive/models/archive_program.dart';
import 'package:radio_lumen_v2/features/archive/providers/archive_provider.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final archiveAsync = ref.watch(filteredArchiveProgramsProvider);
    final searchQuery = ref.watch(archiveSearchQueryProvider);

    return Scaffold(
      body: LumenBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDesignTokens.screenPadding,
                  AppDesignTokens.spacingL,
                  AppDesignTokens.screenPadding,
                  AppDesignTokens.spacingS,
                ),
                child: LumenSearchBar(
                  hintText: l10n.archiveSearchHint,
                  controller: TextEditingController(text: searchQuery)
                    ..selection = TextSelection.fromPosition(
                      TextPosition(offset: searchQuery.length),
                    ),
                  onChanged: (value) {
                    ref.read(archiveSearchQueryProvider.notifier).setQuery(value);
                  },
                  onClear: () {
                    ref.read(archiveSearchQueryProvider.notifier).setQuery('');
                  },
                ),
              ),
              Expanded(
                child: archiveAsync.when(
                  data: (programs) => _buildProgramList(context, programs),
                  loading: () => const LumenLoadingView(),
                  // Pattern: Removed manual retry button to favor automatic refresh via provider logic
                  error: (error, stackTrace) => LumenErrorView(
                    message: l10n.archiveError,
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
    List<ArchiveProgram> programs,
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
      padding: const EdgeInsets.all(AppDesignTokens.screenPadding),
      itemCount: programs.length,
      itemBuilder: (context, index) {
        final program = programs[index];
        return LumenListItem(
          title: program.name,
          subtitle: l10n.archiveEpisodesCount(program.episodes.length),
          onTap: () {
            context.push('/archiv/episodes', extra: program);
          },
        );
      },
    );
  }
}
