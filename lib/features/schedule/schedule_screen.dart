import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(AppLocalizations.of(context)!.navProgram)),
    );
  }
}
