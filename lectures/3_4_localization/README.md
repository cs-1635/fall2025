# Flutter i18n Demo

A minimal Flutter project showing **internationalization (i18n)** and **localization (l10n)** using Flutter's built‑in toolchain (`flutter_localizations`, `intl`, and `gen‑l10n`), including **dynamic locale switching** at runtime via a simple language picker.

## Highlights
- ARB translation files (`lib/l10n/*.arb`) for English (en), Spanish (es), and Arabic (ar)
- Plurals, placeholders, and date formatting examples
- `provider`-backed `LocaleProvider` for changing the app `locale` dynamically
- RTL demo with Arabic
- Auto detection of device locale with graceful fallback

## Run it
```bash
flutter pub get
# Generate localization code from ARB files
flutter gen-l10n
# Run on your device/emulator
flutter run
```
If you modify ARB files, re-run `flutter gen-l10n`.

## Files to check
- `pubspec.yaml` – enables localization generation
- `lib/l10n/app_*.arb` – translation catalogs
- `lib/localization/locale_provider.dart` – locale state
- `lib/main.dart` – MaterialApp, delegates, supported locales, resolution
- `lib/screens/home_screen.dart` – UI with language picker and localized strings

## Notes
- The generated file `lib/generated/app_localizations.dart` is **auto-created** by `flutter gen-l10n` and should not be edited.
- For production apps, consider persisting the chosen locale (e.g., `SharedPreferences`).