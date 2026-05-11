# Copilot Instructions

## Project

Radio Lumen is a Christian radio app for Android and iOS built with Flutter.
It streams live audio content including music, prayers, interviews, and news.
We are recreating the existing Rádio LUMEN app (currently on App Store and Google Play) as a modern Flutter app.

Reference (existing app): https://apps.apple.com/sk/app/r%C3%A1dio-lumen/id544631881

App Goal: To provide spiritual and cultural content while building a community of listeners who can engage anywhere, anytime.

## Core Features

- Live online streaming – real-time radio broadcast, free to use
- Clean mobile UI for audio streaming on smartphones
- Program schedule – current schedule, playlists, show listings
- Religious and cultural content – Christian values, liturgy, spiritual talks, calm music
- Community features – competitions, events, and listener engagement (e.g., 2% tax donation)
- Additional content and services – social media links, news articles, program updates

## Tech Stack

- Dart
- Flutter (Android & iOS)
- Riverpod (state management - MUST use modern `@riverpod` code generation syntax)
- dio (HTTP networking)
- freezed (data models)
- json_serializable (data models)
- build_runner (code generation)
- go_router (navigation and deep linking)
- shared_preferences (local settings storage)
- just_audio (audio streaming and playback)
- audio_service (background audio, lock screen controls)
- Figma Flutter MCP (Figma-to-Flutter widget generation via GitHub Copilot)

## Project Structure

We follow a Feature-First architecture with clear domain separation and team assignments.

Expected structure:
lib/
├── core/ # Global app-wide services and UI
│ ├── network/ # dio client, API interceptors
│ ├── audio/ # just_audio and audio_service handlers
│ ├── theme/ # App colors, fonts (Figma MCP)
│ └── widgets/ # Shared reusable UI components
│
├── features/ # Feature domains (UI, State, and Models)
│ ├── home/ # Home screen, branding, quick play
│ ├── live_player/ # Stream player, controls, song info
│ └── schedule/ # Schedule list, filters, and program details
│
├── routing/ # go_router configuration and Bottom Nav Shell
└── main.dart # App entry point, ProviderScope initialization

## File Generation Rules (CRITICAL)

- NEVER generate code without first stating the exact file path where it belongs.
- Before writing any code, output the target path as a comment (e.g., `// Path: lib/features/live_player/live_player_screen.dart`).
- You MUST adhere strictly to the Project Structure outlined above. Do not create new root folders.

## Documentation

Always follow the latest official documentation:

- Dart: https://dart.dev/guides
- Flutter: https://docs.flutter.dev
- Riverpod: https://riverpod.dev/docs/introduction/getting_started
- Riverpod Code Gen: https://riverpod.dev/docs/concepts/about_code_generation
- go_router: https://pub.dev/packages/go_router
- just_audio: https://pub.dev/packages/just_audio
- audio_service: https://pub.dev/packages/audio_service
- dio: https://pub.dev/packages/dio
- freezed: https://pub.dev/packages/freezed
- json_serializable: https://pub.dev/packages/json_serializable
- build_runner: https://pub.dev/packages/build_runner
- shared_preferences: https://pub.dev/packages/shared_preferences
- Figma Flutter MCP: https://figma.com/plugin-docs

## App Theme

- Defined in Figma (via Figma MCP Server with GitHub Copilot)

## Team

- Bc. Tobiáš Bulko
- Bc. Janka Danišová

## Code Style

- Use const constructors wherever possible
- Prefer StatelessWidget over StatefulWidget unless state is needed
- Use snake_case for file names, PascalCase for class/widget names
- Keep widgets small and single-purpose, extract into separate files

## Reliability

- Prefer official documentation and verified package APIs over assumptions
- Do not generate non-existent Flutter, Dart, or package APIs
- Use null-safe, production-ready Flutter code
- Prefer simple, maintainable solutions over clever but unclear code
- When implementing packages, follow the current official package documentation
- Keep solutions specific, practical, and directly relevant to the requested task

## Language

- App UI language: Slovak
- Code and comments: English

## Git Workflow

- Branch off `development` for all features
- PR back into `development` when done
- `development` → `main` only for stable releases
- Always request a review before merging
- Use conventional commit messages (feat, fix, docs, chore, refactor, style)

## Branch Naming

- tobias/feature-name
- janka/feature-name
