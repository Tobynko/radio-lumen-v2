import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

/// A utility class to access [AppLocalizations] without BuildContext.
/// 
/// This is primarily used in services like AudioHandler.
class L10n {
  L10n._();

  static AppLocalizations? _instance;

  static AppLocalizations get instance {
    if (_instance == null) {
      throw Exception(
        'L10n.instance accessed before being initialized. '
        'Ensure L10n.init() is called in the app root.',
      );
    }
    return _instance!;
  }

  /// Initializes the L10n instance. Should be called in the [Widget.build] 
  /// of the app root or a high-level widget.
  static void init(BuildContext context) {
    _instance = AppLocalizations.of(context);
  }
}
