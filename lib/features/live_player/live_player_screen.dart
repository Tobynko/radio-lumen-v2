import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/features/live_player/widgets/quick_access_player.dart';

class LivePlayerScreen extends StatelessWidget {
  const LivePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: LumenBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        // Logo Section
                        Center(
                          child: Image.asset(
                            'assets/logos/logo.png',
                            height: 180,
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Quick Access Player Card
                        const QuickAccessPlayer(),
                        const SizedBox(height: 40),
                      ],
                    ),
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
