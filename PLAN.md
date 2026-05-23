# Project Plan – Radio Lumen V2

## 🤝 Collaborative / Shared Tasks — STARTING POINT

1. [x] Project scaffold: `pubspec.yaml`, folder structure, `main.dart`, `ProviderScope`
2. [x] App theming: Figma MCP → generate `AppColors` and `AppTextStyles` into `lib/core/theme/`
3. [x] Localization setup: Create `l10n.yaml` and initialize localizations framework with Slovak `.arb` keys
4. [x] Initial app shell and `go_router` navigation setup (Persistent Bottom Nav)
5. [x] Configure shared code generation workflow (`build_runner`) for Riverpod and model generation
6. [x] **Home Screen:** App header with branding, quick access live play button, and short overview of current/upcoming programs (Overview skipped/postponed per user request)
7. [x] Configure and generate native application icons (App Icons) for iOS and Android
8. [x] **Internet Connectivity Check**: Implement real-time network status monitoring using connectivity_plus; display a non-intrusive banner or snackbar when the connection is lost.
9. [x] **Multi-Language Support (SK, EN, HU):** Implement persistent language switching (Riverpod + SharedPreferences), full translation parity across all ARB files, and a visual Language Selector in the About sheet.
10. [x] **Refined About & Info:** Implement reactive "About application" panel with dynamic versioning, legal links, and professional developer attribution for Bc. Tobiáš Bulko and Bc. Janka Danišová.

---

## 🎧 Bc. Tobiáš Bulko: Audio Core & Player Domain

### Core Logic

1. [x] Initialize `just_audio` for live online streaming
2. [x] Configure `audio_service` and native platform files (`AndroidManifest.xml`, `Info.plist` background modes) to handle background audio and lock screen controls
3. [x] Create `@riverpod` providers to manage audio state (playing, paused, buffering, metadata)
4. [x] Implement `shared_preferences` to save user audio settings (e.g., auto-play, volume)

### User Interface

- [x] **Live Player Screen:** Build the mobile UI for audio streaming
- [x] Implement play/pause controls, volume sliders, and live broadcast status
- [x] Display current song/show metadata (Title, Artist, Show Name)
- [x] Ensure the UI reacts to the Riverpod audio state seamlessly
- [x] **Archive Screen:** Implement archive program list and episode list from the base archive URL located in the instructions, following existing schedule/list UI patterns in this project and reusing the current audio player infrastructure for playback.

---

## 📅 Bc. Janka Danišová: Data Core & Schedule Domain

### Core Logic

1. [x] Set up the `dio` HTTP networking client to fetch schedule and playlist data
2. [x] Create data models for Schedule and Shows using `freezed` and `json_serializable`
3. [x] Run `build_runner` to generate model files (also needed for Riverpod code gen)
4. [x] Create `@riverpod` providers to fetch and cache schedule data

### User Interface

- [x] **Schedule Screen:** Build the UI for program schedule, playlists, and show listings
- [x] Implement UI logic to filter or group the schedule by day
- [x] **Program Detail Screen:** Display full details of a selected show/episode
- [x] **News Detail Screen:** Display full details of news and group them by their kind in a tab bar
- [x] **Splashscreen:**, Configure and generate native splash screens for iOS and Android with app branding and background color.
