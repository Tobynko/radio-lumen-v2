// Path: lib/features/schedule/schedule_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_loading_view.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_error_view.dart';
import 'package:radio_lumen_v2/features/schedule/models/schedule_item.dart';
import 'package:radio_lumen_v2/features/schedule/providers/schedule_provider.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_filter_bar.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  int _selectedDayIndex = 2; // Index 2 is today (0 is -2 days, 1 is -1 day)
  late final List<DateTime> _days;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _days = List.generate(10, (index) => today.add(Duration(days: index - 2)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: LumenBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDesignTokens.spacingL),
              Expanded(
                child: Column(
                  children: [
                    _buildDaysFilter(),
                    const SizedBox(height: AppDesignTokens.spacingL),
                    Expanded(
                      child: ref.watch(scheduleProvider).when(
                        data: (items) => _buildScheduleList(l10n, items),
                        loading: () => const LumenLoadingView(),
                        // Pattern: Removed manual retry button to favor automatic refresh via provider logic
                        error: (error, stackTrace) => LumenErrorView(
                          message: l10n.scheduleError,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaysFilter() {
    final locale = Localizations.localeOf(context).toString();

    return LumenFilterBar<DateTime>(
      items: _days,
      selectedItem: _days[_selectedDayIndex],
      onSelected: (date) {
        setState(() {
          _selectedDayIndex = _days.indexOf(date);
        });
      },
      labelBuilder: (date) {
        final dayStr = DateFormat.E(locale).format(date).toUpperCase();
        final dateStr = DateFormat('d.M.').format(date);
        return '$dayStr $dateStr';
      },
      height: 48,
    );
  }

  Widget _buildScheduleList(
    AppLocalizations l10n,
    List<ScheduleItem> allItems,
  ) {
    final selectedDate = _days[_selectedDayIndex];
    final items = allItems.where((item) {
      return item.startTime.year == selectedDate.year &&
          item.startTime.month == selectedDate.month &&
          item.startTime.day == selectedDate.day;
    }).toList();

    items.sort((a, b) => a.startTime.compareTo(b.startTime));

    if (items.isEmpty) {
      return Center(
        child: Text(
          l10n.scheduleNoItems,
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
          ),
        ),
      );
    }

    return ListView.separated(
      key: ValueKey(_selectedDayIndex),
      padding: const EdgeInsets.only(
        left: AppDesignTokens.screenPadding,
        right: AppDesignTokens.screenPadding,
        bottom: AppDesignTokens.spacingXXL,
        top: AppDesignTokens.spacingS,
      ),
      itemCount: items.length,
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDesignTokens.spacingL),
        child: Divider(
          color: Colors.white.withAlpha(AppDesignTokens.alphaDivider),
          height: 1,
        ),
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final startTimeStr = DateFormat('HH:mm').format(item.startTime);

        return InkWell(
          onTap: () {
            context.push('/program-detail', extra: item);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time Column - Standardized to listItemTime
              SizedBox(
                width: 65,
                child: Text(
                  startTimeStr,
                  style: AppTextStyles.listItemTime.copyWith(
                    color: AppColors.accentGold,
                  ),
                ),
              ),
              const SizedBox(width: AppDesignTokens.spacingM),
              // Show Details Column - Standardized to listItemTitle/Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTextStyles.listItemTitle,
                    ),
                    const SizedBox(height: AppDesignTokens.spacingXS),
                    Text(
                      item.description,
                      style: AppTextStyles.listItemSubtitle.copyWith(
                        color: Colors.white.withAlpha(
                          AppDesignTokens.alphaTextSecondary,
                        ),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.show?.host != null) ...[
                      const SizedBox(height: AppDesignTokens.spacingS),
                      Row(
                        children: [
                          Icon(
                            Icons.mic,
                            size: 16,
                            color: AppColors.accentTeal.withAlpha(
                              AppDesignTokens.alphaTextSecondary + 50,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.show!.host!,
                            style: AppTextStyles.listItemSubtitle.copyWith(
                              color: AppColors.accentTeal.withAlpha(
                                AppDesignTokens.alphaTextSecondary + 50,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (item.playUrl != null) ...[
                const SizedBox(width: AppDesignTokens.spacingM),
                IconButton(
                  icon: const Icon(Icons.play_circle_fill),
                  color: AppColors.accentGold,
                  iconSize: 36,
                  onPressed: () {
                    context.push('/archive-player', extra: item);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
