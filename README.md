# Life in Numbers

**A personal life tracker for the moments, activities, and feelings that make up everyday life.**

Life in Numbers is an offline-first Flutter application for recording everyday moments, checking in with emotions, and exploring personal patterns through statistics. It is being developed **Android-first**, with iOS support planned. The first milestone is a useful, approachable **Light** experience; **Premium** features are planned separately.

> **Project status:** Light feature set implemented; pre-release / preparing for device beta testing. The app is not yet published in an app store. Feature-complete does not mean release-ready.

## What works today

- **Personalized onboarding:** A welcome screen with a mascot, name entry, saved profile name, and access to language settings.
- **Dashboard:** Personalized greeting; monthly and all-time counts for moments and feelings; quick-add activity and feeling cards; and rotating highlights and facts.
- **Quick Add:** Record activities in one tap, filter by category, search, and manage individual moment records.
- **Activity management:** Create and edit activities, assign categories, and disable activities while preserving their history.
- **Mood tracking:** Independently log primary emotions in Light, see a dated history of feeling entries, and remove specific entries.
- **Quick corrections:** The `−` button on a moment card opens that activity's record history for selecting a specific entry to delete. The `−` button on a feeling card removes the most recent entry for that emotion; specific feeling entries can be deleted from the Mood page history.
- **Statistics:** Totals and breakdowns for moments and emotions, weekday and monthly patterns, comparisons, charts, and filters.
- **Highlights:** Activity-based summaries and a small set of source-attributed *Did You Know?* facts.
- **Localization:** System-language selection and manual switching between English, German, Portuguese (Portugal), Spanish, and French. Record confirmation messages and the Undo action are localized.
- **Visual identity:** A mascot displayed on the welcome, Add, Emotions, and Statistics screens; Nunito for prominent titles, Oswald for condensed section headings, and DM Sans for smaller text.
- **Local persistence:** Moment and feeling records, activities, and preferences are stored locally on the device; no account or cloud sync is required for the current Light experience.

The mascot artwork is currently **static**; interactive animation is not part of this milestone. Some secondary UI copy or edge-case messages may still need localization review during beta testing.

## Interaction design

Light deliberately gives moments and emotions slightly different correction flows:

| Action | Moments | Feelings |
| --- | --- | --- |
| Tap a Dashboard card | Add a moment | Log a feeling |
| Tap `−` on a Dashboard card | Open that activity's record history | Remove the latest entry for that emotion |
| Delete a specific historical entry | Select it from the moment-history list | Select it from the Mood page history |
| Explore patterns | Statistics | Statistics |

This keeps the Mood page's chronological feeling history useful without duplicating it on the Dashboard. A reversible quick-delete flow for feelings is a potential improvement, not a completed feature.

## Localization and data integrity

The app uses Flutter's localization system (`AppLocalizations`), with ARB files in `lib/l10n/` and configuration in `l10n.yaml`.

- Built-in activity and category **IDs remain stable** across languages.
- Built-in labels are localized at display time rather than rewriting persisted records.
- Custom activity names retain the text entered by their creator.
- Existing moment and basic feeling records must remain available when users change languages or when future Premium capabilities are introduced.

This separation helps keep historical records and statistics independent of the selected interface language.

## Technology

- Flutter and Dart
- Material 3
- `google_fonts` (Nunito, Oswald, DM Sans)
- Flutter localization, ARB resources, and `intl`
- Controllers, models, repositories, and services for application state and persistence
- Shared Preferences-based local storage for current data and preferences

The codebase separates UI from record-management and display-name logic to support future extensions.

## Project organization

```text
## Project organization

lib/
├── controllers/       # Application state and record management
├── core/              # Theme, colors, typography, and shared configuration
├── features/          # Onboarding and settings
├── l10n/              # Localization and ARB translation files
├── models/            # Activities, categories, events, and emotions
├── pages/             # Dashboard, Add, Emotions, Statistics, management
├── services/          # Repositories, highlights, and business logic
├── widgets/           # Reusable UI components
└── main.dart          # App entry point and navigation

assets/
└── mascot/            # Mascot illustrations and assets

test/                  # Automated tests
```

## Getting started

### Prerequisites

- Flutter SDK and Dart compatible with `pubspec.yaml`
- Android SDK and an emulator or Android device for Android testing
- For native iOS builds, access to macOS/Xcode or a compatible macOS cloud build service

### Run locally

```bash
flutter pub get
flutter gen-l10n
flutter run
```

Run static analysis:

```bash
flutter analyze
```

Prepare an Android release APK for **private testing**:

```bash
flutter build apk --release
```

The usual output is `build/app/outputs/flutter-apk/app-release.apk`. Before distributing updates to testers, verify the application identifier, release signing, versioning, and that existing local data survives an upgrade. Building an APK is not the same as publishing to Google Play.

For iPhone beta distribution, the planned route is an iOS build on macOS (locally or through cloud CI), followed by TestFlight. This has **not yet been set up or validated**.

## Roadmap

### Light — first feature milestone

- [x] Personalized onboarding and persistent user name
- [x] Quick activity logging and moment-history management
- [x] Activity management with preserved history for disabled activities
- [x] Primary-emotion logging and chronological feeling history
- [x] Dashboard quick-add and quick-removal actions
- [x] Statistics for moments and feelings
- [x] Highlights and source-attributed facts
- [x] Interface localization across five languages
- [x] Localized record confirmation and Undo labels
- [x] Mascot illustrations on key screens
- [x] Typography alignment and removal of temporary navigation controls
- [ ] Final review of remaining secondary strings, accessibility, and small-screen layouts
- [ ] Validate storage, deletions, and preservation of data across app restarts and updates
- [ ] Stabilize automated tests, including Dashboard `−` interaction coverage
- [ ] Prepare signed Android beta builds and test with real users
- [ ] Prepare and validate iOS/TestFlight beta distribution

### Premium — planned, not implemented

- [ ] Centralize feature access and entitlement state without changing Light records
- [ ] Two-level emotion selection (primary and more specific emotions)
- [ ] Optional association between feelings and recorded moments/activities
- [ ] Deeper statistics and correlations, without claiming causation
- [ ] Premium presentation and purchase / restore flows
- [ ] Explore Apple Health and Android Health Connect integration, subject to feasibility, permissions, and privacy requirements

**Product principle:** Light supports independent primary-emotion logging and access to history. Premium will add detail and context; changing plans must not erase existing Light data.

## Privacy and project scope

Life in Numbers works with personal records, including emotions. The current Light prototype is local-first and does **not** require an account or claim to offer cloud synchronization. Product analytics, payment systems, and third-party health data imports have **not** been implemented.

Before a public release, privacy disclosures, secure backup/migration options, permissions, release signing, and platform-store requirements need review. If analytics are introduced, usage metrics should be designed to avoid transmitting the content of personal mood entries.

## Development status

Life in Numbers is an independently developed Flutter learning and product project. The Light feature set is in place and the next milestone is **real-device beta testing**, followed by stabilization. Premium development will build on the same app rather than creating a separate product.

Screenshots, beta installation instructions, distribution details, and a license can be added once release preparation is complete.
