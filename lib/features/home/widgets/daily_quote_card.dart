// Path: lib/features/home/widgets/daily_quote_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_loading_view.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_error_view.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';
import '../providers/quotes_provider.dart';

class DailyQuoteCard extends ConsumerStatefulWidget {
  const DailyQuoteCard({super.key});

  @override
  ConsumerState<DailyQuoteCard> createState() => _DailyQuoteCardState();
}

class _DailyQuoteCardState extends ConsumerState<DailyQuoteCard> {
  bool _isExpanded = false;
  DateTime _lastTap = DateTime.now();

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _handleNextQuote() {
    // Logic: Debounce fast clicks to prevent animation/state machine collisions.
    final now = DateTime.now();
    if (now.difference(_lastTap).inMilliseconds < 500) return;
    _lastTap = now;
    
    ref.read(quotesProvider.notifier).nextQuote();
  }

  @override
  Widget build(BuildContext context) {
    final quoteAsync = ref.watch(quotesProvider);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBackground),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusXXL),
        border: Border.all(
          color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBorder),
        ),
        boxShadow: AppDesignTokens.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusXXL),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isExpanded ? _handleNextQuote : _toggleExpand,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header (Always Visible)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDesignTokens.spacingXXL,
                    vertical: AppDesignTokens.spacingL,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.format_quote_rounded,
                        color: AppColors.accentGold,
                        size: 28,
                      ),
                      const SizedBox(width: AppDesignTokens.spacingM),
                      Expanded(
                        child: Text(
                          l10n.quoteTitle.toUpperCase(),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white.withAlpha(200),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _toggleExpand,
                        icon: AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns: _isExpanded ? 0.5 : 0,
                          child: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white54,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),

                // Expanded Section with stable transition logic
                AnimatedCrossFade(
                  // Use SizedBox with infinity width to maintain stable layout constraints
                  firstChild: const SizedBox(width: double.infinity, height: 0),
                  secondChild: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      AppDesignTokens.screenPadding,
                      0,
                      AppDesignTokens.screenPadding,
                      AppDesignTokens.spacingXXL,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: quoteAsync.when(
                        data: (quote) => Padding(
                          // Key includes text hash to ensure unique transition for content changes
                          key: ValueKey('daily_quote_content_${quote.text.hashCode}'),
                          padding: const EdgeInsets.only(top: AppDesignTokens.spacingM),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Divider(
                                color: Colors.white10,
                                height: 32,
                              ),
                              Text(
                                quote.text,
                                style: AppTextStyles.bodyLarge.copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppDesignTokens.spacingL),
                              Text(
                                "— ${quote.reference ?? quote.author}",
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.accentGold,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        // Logic: Using UniqueKey() for loading/error. This prevents "Duplicate Key found" 
                        // crashes by ensuring every instance in the animation stack is distinct.
                        loading: () => SizedBox(
                          key: UniqueKey(),
                          height: 120,
                          child: const LumenLoadingView(),
                        ),
                        error: (err, stack) => SizedBox(
                          key: UniqueKey(),
                          height: 120,
                          child: LumenErrorView(
                            message: l10n.quoteError,
                          ),
                        ),
                      ),
                    ),
                  ),
                  crossFadeState: _isExpanded 
                      ? CrossFadeState.showSecond 
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
