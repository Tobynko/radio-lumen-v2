# Project Plan – Radio Lumen V2

## 🤝 Collaborative / Shared Tasks — STARTING POINT

1. [x] Project scaffold: `pubspec.yaml`, folder structure, `main.dart`, `ProviderScope`
2. [x] App theming: Figma MCP → generate `AppColors` and `AppTextStyles` into `lib/core/theme/`
3. [x] Localization setup: Create `l10n.yaml` and initialize localizations framework with Slovak `.arb` keys
4. [x] Initial app shell and `go_router` navigation setup (Persistent Bottom Nav)
5. [x] Configure shared code generation workflow (`build_runner`) for Riverpod and model generation
6. [x] **Home Screen:** App header with branding, quick access live play button, and short overview of current/upcoming programs (Overview skipped/postponed per user request)

---

## 🎧 Bc. Tobiáš Bulko: Audio Core & Player Domain

### Core Logic

1. [ ] Initialize `just_audio` for live online streaming
2. [ ] Configure `audio_service` and native platform files (`AndroidManifest.xml`, `Info.plist` background modes) to handle background audio and lock screen controls
3. [ ] Create `@riverpod` providers to manage audio state (playing, paused, buffering, metadata)
4. [ ] Implement `shared_preferences` to save user audio settings (e.g., auto-play, volume)

### User Interface

- [ ] **Live Player Screen:** Build the mobile UI for audio streaming
- [ ] Implement play/pause controls, volume sliders, and live broadcast status
- [ ] Display current song/show metadata (Title, Artist, Show Name)
- [ ] Ensure the UI reacts to the Riverpod audio state seamlessly
- [ ] **Program Detail Screen:** Display full details of a selected show/episode _(requires Schedule models from Janka)_

---

## 📅 Bc. Janka Danišová: Data Core & Schedule Domain

### Core Logic

1. [x] Set up the `dio` HTTP networking client to fetch schedule and playlist data
2. [ ] Create data models for Schedule and Shows using `freezed` and `json_serializable`
3. [ ] Run `build_runner` to generate model files (also needed for Riverpod code gen)
4. [ ] Create `@riverpod` providers to fetch and cache schedule data

### User Interface

- [ ] **Schedule Screen:** Build the UI for program schedule, playlists, and show listings
- [ ] Implement UI logic to filter or group the schedule by day
- [ ] Display content tags (e.g., liturgy, calm music) on schedule items
