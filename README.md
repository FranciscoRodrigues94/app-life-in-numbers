# Life in Numbers

**A personal life tracker for the moments, activities, and feelings that make up everyday life.**

Life in Numbers is an offline-first mobile application built with **Flutter and Dart**. It helps users record everyday moments, track emotions, and discover personal patterns through statistics.

The application is developed **Android-first**, with iOS support planned. Its first milestone is a useful, approachable **Light** experience, with additional **Premium** capabilities planned for future development.

> **Project status:** Light feature set implemented. Android beta preparation and native home screen widget development are in progress. The application is not yet published in an app store.

## What works today

### Core functionality

- **Personalized onboarding:** Welcome screen with an animated mascot, name entry, persistent user profile name, and language selection.
- **Dashboard:** Personalized greeting, monthly and all-time counts for moments and feelings, quick-add cards, and rotating highlights.
- **Quick Add:** Record activities with a single tap, browse by category, search activities, and manage individual moment records.
- **Activity management:** Create, edit, categorize, and deactivate activities while preserving historical records.
- **Mood tracking:** Independently record primary emotions, explore chronological feeling history, and delete individual entries.
- **Statistics:** Explore moment and emotion totals, distributions, weekday and monthly patterns, comparisons, charts, and filters.
- **Highlights:** Activity-based summaries and selected source-attributed *Did You Know?* facts.

### User experience

- **Animated mascot:** A custom character with animated body parts on the Welcome screen and expressive illustrations throughout the application.
- **Animated splash screen:** A short branded animation displayed during Flutter application startup.
- **Custom Android launcher icon:** A recognizable mascot-based icon generated for Android launchers.
- **Quick corrections:** Remove individual moment entries through their history, or remove the latest occurrence of an emotion from the Dashboard.
- **Localized interface:** English, German, Portuguese (Portugal), Spanish, and French.
- **Design system:** Consistent colors, typography, rounded components, and Material 3-based interface patterns.

### Offline functionality

- Local persistence for moments, feelings, activities, and user preferences.
- No account registration required.
- No cloud synchronization required.
- Existing records remain independent of the selected interface language.

Some secondary UI messages, accessibility details, and edge cases remain under review during beta preparation.

## Android Home Screen Widget — In Development

A compact **2 × 2 Android home screen widget** is being developed to make everyday tracking faster.

### Planned behavior

- Automatically display the two most frequently recorded moments.
- Automatically display the two most frequently recorded primary emotions.
- Allow users to record a moment or feeling directly from the widget.
- Provide a `+` shortcut that opens the application's Dashboard.
- Update the displayed shortcuts as the user's habits change.

### Current implementation status

- [x] Initial widget design and interaction requirements
- [x] Flutter `home_widget` dependency added
- [x] Initial native Android layout and drawable resources
- [x] Android widget provider and manifest registration implemented
- [ ] Verify native Android compilation and launcher rendering
- [ ] Connect the widget to real activity and emotion frequencies
- [ ] Implement direct recording from the widget
- [ ] Add reliable synchronization and duplicate prevention
- [ ] Validate widget behavior on Android devices

Direct widget recording is **not yet complete**. The implementation must preserve existing records and remain compatible with the application's offline-first storage architecture.

## Interaction design

Moments and feelings use slightly different correction flows in the Light version.

| Action | Moments | Feelings |
|---|---|---|
| Tap a Dashboard card | Add a moment | Log a feeling |
| Tap `−` on a Dashboard card | Open that activity's record history | Remove its latest feeling entry |
| Delete a specific entry | Select it from moment history | Select it from Mood history |
| Explore patterns | Statistics | Statistics |

This maintains a useful chronological feeling history without duplicating the same interface on the Dashboard.

An improved reversible correction flow for feelings remains a potential enhancement.

## Localization and data integrity

Life in Numbers uses Flutter's localization system (`AppLocalizations`), ARB resources in `lib/l10n/`, and configuration in `l10n.yaml`.

Key principles:

- Built-in activity and category IDs remain stable across languages.
- Built-in labels are localized at display time instead of modifying persisted records.
- Custom activity names preserve user-entered text.
- Existing records remain available when users change languages.
- Future Premium features must not erase or invalidate Light records.

The application separates persistent identifiers from translated display names to maintain consistency across statistics, history, and future integrations.

## Technology stack

| Area | Technology |
|---|---|
| Application framework | Flutter |
| Programming language | Dart |
| UI framework | Material 3 |
| Typography | Google Fonts |
| Localization | Flutter localization, ARB, intl |
| Local storage | SharedPreferencesAsync |
| Architecture | Controllers, models, repositories, services |
| Android integration | Kotlin, XML, AndroidManifest |
| Home screen widget | home_widget (integration in progress) |
| Version control | Git and GitHub |

The codebase separates presentation, application state, record management, persistence, and display-name logic.

### Development approach

The project is developed iteratively with AI-assisted development, manual validation, static analysis, and automated tests.

Current development priorities include functionality, user experience, data integrity, and maintainability.

Before a public release, the application will require additional testing, platform validation, and security and privacy review.

## Project organization

```text
lib/
├── controllers/       # Application state and record management
├── core/              # Theme, colors, typography, configuration
├── features/          # Onboarding, splash screen, settings
├── l10n/              # Localization and ARB translation files
├── models/            # Activities, categories, events, emotions
├── pages/             # Dashboard, Add, Mood, Statistics
├── services/          # Storage, repositories, business logic
├── widgets/           # Reusable Flutter UI components
└── main.dart          # App entry point and navigation

assets/
├── mascot/            # Mascot illustrations and animations
└── icon/              # Android launcher icon assets

android/
└── app/src/main/
    ├── kotlin/        # Native Android integration
    └── res/           # Android layouts, drawables and widgets

test/                  # Automated tests
```

## Getting started

### Prerequisites

- Flutter SDK and Dart compatible with `pubspec.yaml`
- Android SDK for Android builds
- Android emulator or physical device for native Android testing
- macOS/Xcode or a compatible macOS build environment for iOS development

### Run locally

```bash
flutter pub get
flutter gen-l10n
flutter run
```

### Static analysis

```bash
flutter analyze
```

### Run automated tests

```bash
flutter test
```

Some automated tests remain under review as the Light interface evolves.

### Build Android APK

For development testing:

```bash
flutter build apk --debug
```

For release preparation:

```bash
flutter build apk --release
```

The usual release output is:

`build/app/outputs/flutter-apk/app-release.apk`

Before distributing updates, verify application identifiers, signing configuration, versioning, and preservation of locally stored records across upgrades.

Building an APK does not publish the application to Google Play.

### iOS

iOS support is planned but has not yet been built or validated.

The intended beta distribution route is TestFlight, following a successful iOS build and platform testing.

## Roadmap

### Light — Core application

- [x] Personalized onboarding
- [x] Persistent user profile name
- [x] Moment and activity tracking
- [x] Activity creation, editing, and deactivation
- [x] Primary-emotion tracking and history
- [x] Dashboard quick-recording actions
- [x] Statistics for moments and feelings
- [x] Highlights and educational facts
- [x] Localization across five languages
- [x] Localized recording confirmations and Undo actions
- [x] Redesigned mascot illustrations
- [x] Animated Welcome mascot
- [x] Custom Android launcher icon
- [x] Animated Flutter splash screen

### Light — Beta preparation

- [ ] Complete Android home screen widget
- [ ] Validate native widget interactions
- [ ] Review remaining secondary translations
- [ ] Improve accessibility and small-screen behavior
- [ ] Verify persistence across application restarts and updates
- [ ] Stabilize automated tests and Dashboard correction flows
- [ ] Complete real-device Android beta testing
- [ ] Prepare signed APK distribution to testers
- [ ] Prepare iOS and TestFlight testing

### Premium — Planned, not implemented

- [ ] Feature access and entitlement management
- [ ] Two-level emotion selection
- [ ] Optional association between emotions and activities
- [ ] Advanced statistics and personal correlations
- [ ] Premium subscription and purchase restoration
- [ ] Explore Apple Health integration
- [ ] Explore Android Health Connect integration
- [ ] Optional cloud synchronization and backup

**Product principle:** Light provides independent primary-emotion tracking and historical records. Premium will introduce additional detail, context, and integrations without deleting existing Light data.

## Privacy and data management

Life in Numbers handles personal records, including emotional check-ins.

The current Light implementation is designed around local storage and does not require user accounts or cloud synchronization.

The application currently does not implement:

- Product analytics tracking
- Cloud-based user profiles
- Payment processing
- Third-party health data imports

Before public release, the following areas require further attention:

- Privacy disclosures and platform requirements
- Secure backup, export, and potential migration
- Data integrity and recovery
- Android and iOS permissions
- Release signing and security validation
- Protection of sensitive personal information

Any future analytics implementation should avoid transmitting the contents of personal mood records without an appropriate privacy design and user consent.

## Development status

Life in Numbers is an independently developed, AI-assisted Flutter learning and product project.

The project combines application development, user interface design, state management, data persistence, localization, Android native integration, and iterative testing.

The immediate development milestone is completing the Android home screen widget and preparing the Light version for real-device beta testing.

Future Premium functionality will extend the existing application rather than creating a separate product.

Screenshots, beta installation instructions, distribution information, and licensing details will be added as the project progresses.
