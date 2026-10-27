# Life in Numbers

**A personal life tracker for the moments, activities, and feelings that make up everyday life.**

Life in Numbers is a Flutter application that helps you record everyday moments with a tap, reflect on your emotions, and explore your personal history through simple statistics. The project is being developed with an **offline-first, Android-first** approach, with an initial focus on a useful and approachable free experience (the **Light** version).

> **Project status:** Active development / pre-release. The app is not yet published in an app store.

## What works today

- **Personalized onboarding:** A welcome flow that asks for your name and remembers it between sessions.
- **Dashboard:** A personalized greeting, monthly and all-time summaries, recorded activities and emotions, and rotating highlights.
- **Quick Add:** Record an activity with one tap, browse by category, search activities, and review or remove individual records.
- **Activity management:** Create and edit activities, choose a category, and enable or disable activities without discarding their recorded history.
- **Mood tracking:** Log primary emotions independently of activities in the Light experience.
- **Statistics:** View totals, activity breakdowns, weekday patterns, monthly trends, and emotion statistics using interactive charts and filters.
- **Highlights:** Data-driven summaries based on recorded activity and a small set of source-linked *Did You Know?* facts.
- **Localization:** An automatic system-language option and manual language selection, with interface translations for English, German, Portuguese, Spanish, and French.
- **Local persistence:** Keep personal records and preferences on the device in the current implementation.

Some generated **statistics insights**, notification messages, and other secondary text are still being localized. Language coverage is a work in progress.

## Localization and data integrity

The app uses Flutter's localization system (`AppLocalizations`) and ARB files in `lib/l10n/`.

- Activity and category **IDs remain stable** across languages.
- Built-in activity and category labels are translated when displayed rather than written back into stored records.
- User-defined activity names remain unchanged.
- Previously recorded moments and basic emotion entries are intended to remain available as the app evolves.

This separation helps keep statistics and historical data independent of the selected interface language.

## Technology

- **Flutter and Dart**
- **Material 3** UI
- **Flutter localization**, ARB resources, and `intl`
- **Local repositories and controllers** for app state and persistence
- **Shared Preferences** for onboarding and language preferences

The current codebase separates models, repositories, services, controllers, and UI pages to make future changes easier to manage.

## Project organization

```text
lib/
├── controllers/      # Application state and record management
├── core/theme/       # Colors, typography, and visual styles
├── features/         # Feature-specific screens (e.g., onboarding, settings)
├── l10n/             # Translation source files
├── models/           # Activities, categories, events, emotions
├── pages/            # Dashboard, Add, Mood, Statistics, management
├── services/         # Repositories, statistics, highlights, display names
└── main.dart         # App entry point, initialization, navigation

test/                # Automated tests (under ongoing development)
```

## Getting started

### Prerequisites

- Flutter SDK and Dart (a compatible version for `pubspec.yaml`)
- Android SDK and an Android device or emulator

### Run locally

```bash
flutter pub get
flutter gen-l10n
flutter run
```

To run static analysis:

```bash
flutter analyze
```

> This project is currently developed primarily for Android. iOS support is a future goal and has not been validated as part of the current milestone.

## Roadmap

### Light — current focus

- [x] Personalized welcome experience and saved user name
- [x] Quick activity logging and local history
- [x] Activity and category display-name localization
- [x] Basic emotion logging
- [x] Statistics and chart views for moments and emotions
- [x] Language preferences and core interface translations
- [ ] Finish localization of generated insights and remaining messages
- [ ] Refine onboarding visuals and introduce the planned animated mascot
- [ ] Polish UI, accessibility, and edge cases
- [ ] Stabilize automated tests and prepare an initial Android release

### Premium — planned, not implemented

- [ ] More detailed emotions using a two-level emotion wheel
- [ ] Optional feelings associated with recorded activities or moments
- [ ] More advanced personal insights and patterns
- [ ] Explore integrations with health/activity platforms, subject to feasibility and permissions

**Product principle:** The Light version supports independent primary-emotion logging. Premium is planned to add detail and context without invalidating existing Light data.

## Privacy and project scope

Life in Numbers is designed around personal information. The current MVP prioritizes local recording rather than requiring a cloud account. Cloud synchronization, account infrastructure, and third-party health integrations are **not** claimed as existing features.

This README describes the development prototype, not a finished security or privacy certification. Data handling and release readiness will be reviewed before public distribution.

## Development status

This is an evolving personal software project, built incrementally with an emphasis on learning Flutter/Dart, practical software architecture, and a clear user experience.

Screenshots, release instructions, and license information can be added when the project is ready for public distribution.
