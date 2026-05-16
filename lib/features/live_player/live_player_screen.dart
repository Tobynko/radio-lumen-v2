import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

class LivePlayerScreen extends StatelessWidget {
  const LivePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(AppLocalizations.of(context)!.navLive)),
    );
  }
}
