import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/features/schedule/models/schedule_item.dart';

class ProgramDetailScreen extends StatelessWidget {
  final ScheduleItem item;

  const ProgramDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final dayStr = DateFormat.EEEE(locale).format(item.startTime);
    final dateStr = DateFormat('d.M.yyyy').format(item.startTime);
    final startTimeStr = DateFormat('HH:mm').format(item.startTime);
    final endTimeStr = DateFormat('HH:mm').format(item.endTime);
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: LumenBackground(
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 56), // Space for custom back button
                    // Header Icon/Image Placeholder
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withValues(alpha: 0.5),
                          border: Border.all(
                            color: AppColors.accentGold,
                            width: 3,
                          ),
                        ),
                        child: const Icon(
                          Icons.headset_mic,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    Text(
                      item.title,
                      style: AppTextStyles.displayLarge.copyWith(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Time & Date info
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: AppColors.accentGold,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$dayStr, $dateStr',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 20,
                          color: AppColors.accentGold,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$startTimeStr - $endTimeStr',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.accentGold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Host info (if available)
                    if (item.show?.host != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 24,
                            color: AppColors.accentTeal,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            item.show!.host!,
                            style: AppTextStyles.titleLarge.copyWith(
                              color: AppColors.accentTeal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Description
                    Text(
                      item.description,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Tags
                    if (item.tags.isNotEmpty) ...[
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: item.tags
                            .map((tag) => _buildTag(tag))
                            .toList(),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ],
                ),
              ),
            ),
            // Glassmorphism Back Button (matching NewsDetail)
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

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white.withValues(alpha: 0.9),
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
