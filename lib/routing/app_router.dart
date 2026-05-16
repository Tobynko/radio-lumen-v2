import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_lumen_v2/features/archive/archive_screen.dart';
import 'package:radio_lumen_v2/features/live_player/live_player_screen.dart';
import 'package:radio_lumen_v2/features/main_shell.dart';
import 'package:radio_lumen_v2/features/prayers/prayers_screen.dart';
import 'package:radio_lumen_v2/features/schedule/schedule_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorProgramKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellProgram',
);
final _shellNavigatorArchivKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellArchiv',
);
final _shellNavigatorModlitbyKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellModlitby',
);
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellHome',
);

final appRouter = GoRouter(
  initialLocation: '/program',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProgramKey,
          routes: [
            GoRoute(
              path: '/program',
              builder: (context, state) => const ScheduleScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorArchivKey,
          routes: [
            GoRoute(
              path: '/archiv',
              builder: (context, state) => const ArchiveScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorModlitbyKey,
          routes: [
            GoRoute(
              path: '/motlitby',
              builder: (context, state) => const PrayersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/live',
              builder: (context, state) => const LivePlayerScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
