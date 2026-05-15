# Gemini Agent Instructions

You are assisting with development of Radio Lumen V2.

## Core Directives

- Use `.github/copilot-instructions.md` as the source of project architecture and coding conventions.
- If any instruction there conflicts with my direct prompt, ask before proceeding.
- Use `PLAN.md` as a roadmap and source of task order, but do not start implementing steps unless I explicitly ask.
- If I ask a question about models, files, setup, or config, answer only that question and do not modify files.

## MCP & Tool Usage

- Use Flutter/Dart MCP tools when they help verify, inspect, or diagnose issues.
- Use the Figma Flutter MCP only when we are actively working on a UI task from the plan or I explicitly ask to inspect a design.
- Prefer inspection and analysis before generating code from Figma.
- After modifying `pubspec.yaml`, suggest running `flutter pub get`; only run it if I ask or approve.
- After creating or updating `freezed` or `json_serializable` models, suggest running `dart run build_runner build -d`; only run it if I ask or approve.
- If a Flutter or Dart error occurs, prefer tool-based analysis over guessing.

## Safety

- Do not modify files, run commands, or scaffold code unless I explicitly ask.
- If the next action is ambiguous, ask before proceeding.
