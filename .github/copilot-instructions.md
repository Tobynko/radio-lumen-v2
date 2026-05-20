# Copilot Instructions

## Project

Radio Lumen is a Christian radio app for Android and iOS built with Flutter.
It streams live audio content including music, prayers, interviews, and news.
We are recreating the existing Rádio LUMEN app (currently on App Store and Google Play) as a modern Flutter app.

Reference (existing app): [App Store](https://apps.apple.com/sk/app/r%C3%A1dio-lumen/id544631881), [Google Play](https://play.google.com/store/apps/details?id=com.apptives.radiolumen&hl=en-US)

App Goal: To provide spiritual and cultural content while building a community of listeners who can engage anywhere, anytime.

## Core Features

- Live online streaming – real-time radio broadcast
- Clean mobile UI for audio streaming on smartphones
- Program schedule – current schedule, playlists, show listings
- Religious and cultural content – Christian values, liturgy, spiritual talks, calm music
- Community features – competitions, events, and listener engagement (e.g., 2% tax donation)
- Additional content and services – social media links, news articles, program updates

## Tech Stack

- Dart
- Flutter (Android & iOS)
- flutter_localizations (Flutter l10n)
- Riverpod (state management - MUST use modern `@riverpod` code generation syntax)
- dio (HTTP networking)
- html (HTML parsing for schedule web scraping)
- freezed (data models)
- json_serializable (data models)
- build_runner (code generation)
- go_router (navigation and deep linking)
- shared_preferences (local settings storage)
- just_audio (audio streaming and playback)
- audio_service (background audio, lock screen controls)
- flutter_svg (SVG rendering for Figma vector icons)
- Figma Flutter MCP (Figma-to-Flutter widget generation via AI)

## External Data Sources & Endpoints

Use these live public targets for feature implementation. Do not hardcode them scattered across screens; centralize them within their respective data source files.

### Audio Streaming (Icecast Feed)

- **High Quality (128 kbps MP3):** `https://audio.lumen.sk/live128.mp3`
- **Medium Quality (64 kbps):** `https://audio.lumen.sk/live64.mp3`
- **Low Quality (32 kbps MP3):** `https://audio.lumen.sk/live32.mp3`

### Schedule & Content (Web Scraping Target)

- **Base Program URL:** `https://www.lumen.sk/aktualny-program.html`

### Archive & Podcast Feed

- **Base Archive URL:** `https://www.lumen.sk/podcastg.html`

### News / Aktuality (Web Scraping Target)

- **All news:** https://www.lumen.sk/aktuality.html%60
Z nášho vysielania: https://www.lumen.sk/aktuality/z-nasho-vysielania.html
Novinky: https://www.lumen.sk/aktuality/novinky.html
Spravodajstvo: `https://www.lumen.sk/aktuality/spravodajstvo.html%60%60

## Project Structure

We follow a Feature-First architecture with clear domain separation.

Expected structure:

```
├── assets/
│   ├── animations/ # audio_wave_indicator.json, buffer_loader.json
│   ├── fonts/      # BrandFont-Regular.ttf, BrandFont-Bold.ttf etc
│   ├── icons/      # ic_program.svg, ic_domov.svg, ic_archiv.svg
│   ├── logos/      # app_logo.png
│   └── images/     # default_show_cover.jpg, splash_bg.png
│
└── lib/
    ├── core/ # Global app-wide services and UI
    │   ├── network/ # dio client, API interceptors
    │   ├── audio/   # just_audio and audio_service handlers
    │   ├── theme/   # App colors, fonts (Figma MCP)
    │   └── widgets/ # Shared reusable UI components
    │
    ├── features/ # Feature domains (UI, State, and Models)
    │   ├── home/        # Home screen, branding, quick play
    │   ├── live_player/ # Stream player, controls, song info
    │   └── schedule/    # Schedule list, filters, and program details
    │
    ├── routing/ # go_router configuration and Bottom Nav Shell
    └── main.dart # App entry point, ProviderScope initialization
```

Each feature folder follows this internal structure:

```
features/<feature>/
├── <feature>_screen.dart # Main screen widget
├── <feature>_controller.dart # @riverpod provider/notifier
└── models/ # freezed + json_serializable models
```

## Architecture Rules (MUST ENFORCE)

- All new code belongs in either `lib/features/<feature>/`, `lib/core/` or `lib/routing/` — no exceptions. Do not create new root folders.
- Never import from one feature into another — shared UI goes in `lib/core/widgets/`
- Feature-to-feature communication uses shared Riverpod providers in `lib/core/`, never direct imports
- All audio logic lives in `lib/core/audio/` — never instantiate `AudioPlayer` or `AudioHandler` outside this folder
- All network logic lives in `lib/core/network/` — never instantiate `Dio` outside this folder
- All theme values come from `lib/core/theme/` — never hardcode colors or fonts

## File Generation (REQUIRED)

- State the exact file path as a comment before writing code
- Example: `// Path: lib/features/live_player/live_player_screen.dart`
- Use this pattern for every new file

## Code Standards

### Style Guidelines

- Use const constructors wherever possible
- Prefer StatelessWidget over StatefulWidget unless state is needed
- Use snake_case for file names, PascalCase for class/widget names
- Keep widgets small and single-purpose, extract into separate files
- All freezed models must include the `part '<filename>.freezed.dart';` and `part '<filename>.g.dart';` directives

### Reliability & Quality

- Use null-safe Flutter code that follows official package documentation and compiles without warnings
- Do not generate non-existent Flutter, Dart, or package APIs
- Prefer simple, maintainable solutions over clever code
- Keep solutions specific, practical, and directly relevant

### Audio & Streaming

- Handle all audio state errors in `lib/core/audio/`
- If the stream fails to load, display an error message to the user
- Handle network interruptions with retry logic before surfacing an error
- Never leave the player in a broken state silently — always notify the user or recover

## Localization & Language

- App UI language: Slovak
- Store all text strings in localization files — never hardcode UI strings inline
- If a localization key is missing, log an error and fall back to the English equivalent
- Code comments and documentation: English

## Documentation References

Follow latest official docs:

- **Dart:** https://dart.dev/guides
- **Flutter:** https://docs.flutter.dev
- **Flutter Localization:** https://docs.flutter.dev/development/accessibility-and-localization/internationalization
- **Riverpod:** https://riverpod.dev/docs/introduction/getting_started
- **Riverpod Code Gen:** https://riverpod.dev/docs/concepts/about_code_generation
- **dio:** https://pub.dev/packages/dio
- **html:** https://pub.dev/packages/html
- **freezed:** https://pub.dev/packages/freezed
- **json_serializable:** https://pub.dev/packages/json_serializable
- **build_runner:** https://pub.dev/packages/build_runner
- **go_router:** https://pub.dev/packages/go_router
- **shared_preferences:** https://pub.dev/packages/shared_preferences
- **just_audio:** https://pub.dev/packages/just_audio
- **audio_service:** https://pub.dev/packages/audio_service
- **flutter_svg:** https://pub.dev/packages/flutter_svg
- **Figma Flutter MCP:** https://github.com/mhmzdev/figma-flutter-mcp

## Git Workflow

- Branch off `development` for all features
- PR back into `development` when done
- `development` → `main` only for stable releases
- Always request a review before merging
- Use conventional commit messages: `feat`, `fix`, `docs`, `chore`, `refactor`, `style`

### Branch Naming Convention

- `tobias/feature-name`
- `janka/feature-name`

## Team

- Bc. Tobiáš Bulko
- Bc. Janka Danišová

## App Theme

- Defined in Figma via Figma MCP Server with GitHub Copilot
- All theme tokens (colors, typography, spacing) are generated into `lib/core/theme/`
- Use `AppColors.<token>` and `AppTextStyles.<token>` — never hardcode color values or font sizes inline
- Do not override theme values at the widget level unless absolutely necessary
