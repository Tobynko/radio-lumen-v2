# Radio Lumen V2

Rádio Lumen je kresťanská rozhlasová aplikácia pre Android a iOS. Streamuje živý audio obsah vrátane hudby, modlitieb, rozhovorov a správ.

Existujúcu aplikáciu Rádio LUMEN (dostupná v [App Store](https://apps.apple.com/sk/app/r%C3%A1dio-lumen/id544631881) a [Google Play](https://play.google.com/store/apps/details?id=com.apptives.radiolumen&hl=en-US)) sme pretvorili na modernú Flutter aplikáciu.

## Hlavné vlastnosti

- _Živé online vysielanie_ – počúvanie programuv reálnom čase bezplatne.
- _Mobilná aplikácia_ – prehľadné rozhranie na streamovanie priamo v smartfóne.
- _Program a relácie_ – aktuálny program, playlisty, rozpis relácií (hudba, modlitby, rozhovory, spravodajstvo).
- _Náboženský a kultúrny obsah_ – kresťanské hodnoty, liturgia, duchovné rozhovory a upokojujúca hudba.

### Snímky obrazoviek (GUI)

## Požiadavky na prostredie

Pre úspešné spustenie projektu je potrebné mať nainštalované:

- _Flutter SDK_ (verzia 3.+)
- _Node.js_ (pre beh Gemini CLI nástrojov)

## Návod na spustenie

Zadať v konzoli:

```bash
flutter pub get
```

```bash
dart run build_runner build --delete-conflicting-outputs
```

```bash
flutter run
```

## Zvolené LLM

Pôvodný plán bol využiť pri vývoji _GitHub Copilot_, keďže sme mali prístup k _Education Pack for Students_. Avšak v čase, keď sme po dôkladnom plánovaní chceli začať s vývojom, GitHub práve pozastavil svoje predplatiteľské služby.

- [Announcement & FAQ: Changes to GitHub Copilot Individual Plans](https://github.com/orgs/community/discussions/192963)
- [Changes to GitHub Copilot Individual plans](https://github.blog/news-insights/company-news/changes-to-github-copilot-individual-plans/)

Po zvážení iných možností a LLM nástrojov sme vybrali **Gemini od spoločnosti Google**. Konkrétne [Gemini CLI](https://geminicli.com/) + [Gemini CLI Companion rozšírenie](https://marketplace.visualstudio.com/items?itemName=Google.gemini-cli-vscode-ide-companion) vo VS Code.

Veľkou výhodou Gemini CLI je jeho schopnosť čítať inštruktážne súbory iných LLM, vďaka čomu sme nemuseli zložito prepisovať alebo upravovať existujúce inštrukcie pôvodne určené pre GitHub Copilot, ktoré boli uložené v `.github/copilot-instructions.md`. Pre potreby Gemini sme však vytvorili samostatný súbor `GEMINI.md`, v ktorom boli zadefinované operačné inštrukcie pre správanie AI agenta, pravidlá bezpečnej manipulácie s kódom a riadenie MCP nástrojov, pričom samotné architektonické pravidlá a konvencie asistent preberá z pôvodného súboru pre Copilot.

Inštalácia Gemini CLI v projekte:

```bash
npm install -g @google/gemini-cli
```

<p align="center">
  <img src="docs/screenshots/tobias/gemini-models.png" width="49%" />
</p>

Aby sme zabezpečili, že kód vygenerovaný pomocou AI bude čo najkvalitnejší, nainštalovali sme do Gemini CLI aj oficiálne rozšírenie (MCP) pre Flutter. Toto rozšírenie rozširuje a dopĺňa pravidlá kvality kódu (code quality) z našich vlastných inštrukcií a zároveň v sebe integruje dodatočné nástroje na testovanie a statickú analýzu čistoty kódu. Okrem toho sme integrovali aj Figma Flutter MCP pre priamu prácu s grafickými návrhmi a UI podkladmi z platformy Figma.

- [Figma Flutter MCP](https://github.com/mhmzdev/figma-flutter-mcp)
- [Gemini CLI Flutter extension](https://geminicli.com/extensions/?name=gemini-cli-extensionsflutter)

```bash
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    },
    "figma-flutter": {
      "command": "npx",
      "args": ["-y", "figma-flutter-mcp", "--stdio"],
      "env": {
        "FIGMA_API_KEY": "${FIGMA_API_KEY}"
      }
    }
  }
}
```

<p align="center">
  <img src="docs/screenshots/tobias/mcp1.png" width="49%" />
  <img src="docs/screenshots/tobias/mcp2.png" width="49%" />
</p>

### Iné použité AI nástroje

Pre konzultáciu, otázky a iné veci boli použité tieto AI:

- _Platený Google Gemini Plus & Pro_
- _Platený Perplexity (Claude Sonnet 4.6 Thinking model)_

### Prínosy a nevýhody

## Zoznam technológií a použitých knižníc

- _Dart_
- _Flutter_ (Android & iOS)
- _flutter_localizations_ (Flutter l10n)
- _Riverpod_ (state management)
- _dio_ (HTTP networking)
- _html_ (HTML parsing for schedule web scraping)
- _freezed_ (data models)
- _json_serializable_ (data models)
- _build_runner_ (code generation)
- _go_router_ (navigation and deep linking)
- _shared_preferences_ (local settings storage)
- _just_audio_ (audio streaming and playback)
- _audio_service_ (background audio, lock screen controls)
- _flutter_svg_ (SVG rendering for Figma vector icons)
- _Figma Flutter MCP_ (Figma-to-Flutter widget generation via AI)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
