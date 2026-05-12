# Project Plan – Radio Lumen V2

## 🤝 Collaborative / Shared Tasks — STARTING POINT

1. [ ] Project scaffold: `pubspec.yaml`, folder structure, `main.dart`, `ProviderScope`
2. [ ] App theming: Figma MCP → generate `AppColors` and `AppTextStyles` into `lib/core/theme/`
3. [ ] Initial app shell and `go_router` navigation setup (Persistent Bottom Nav)
4. [ ] **Home Screen:** App header with branding, quick access live play button, and short overview of current/upcoming programs

---

## 🎧 Bc. Tobiáš Bulko: Audio Core & Player Domain

### Core Logic

1. [ ] Initialize `just_audio` for live online streaming
2. [ ] Configure `audio_service` to handle background audio and lock screen controls
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

1. [ ] Set up the `dio` HTTP networking client to fetch schedule and playlist data
2. [ ] Create data models for Schedule and Shows using `freezed` and `json_serializable`
3. [ ] Run `build_runner` to generate model files (also needed for Riverpod code gen)
4. [ ] Create `@riverpod` providers to fetch and cache schedule data

### User Interface

- [ ] **Schedule Screen:** Build the UI for program schedule, playlists, and show listings
- [ ] Implement UI logic to filter or group the schedule by day
- [ ] Display content tags (e.g., liturgy, calm music) on schedule items
