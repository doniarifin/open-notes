# open_notes

A Flutter-based offline note-taking app. Notes are stored locally using SQLite (sqflite).

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel, >= 3.x)
- VS Code / Android Studio / Xcode (for device builds)
- A connected device or emulator (optional, for running the app)

## Setup

```sh
# Install dependencies
flutter pub get
```

## Run the app

### Debug (hot reload)

```sh
flutter run
```

To run on a specific device, list available devices first:

```sh
flutter devices
flutter run -d <device-id>
```

While running in debug mode, press `r` to hot-reload and `R` to hot-restart.

## Build for release

### Android

```sh
# APK (debug)
flutter build apk --debug

# APK (release)
flutter build apk --release

# Bundle for Play Store
flutter build appbundle --release
```

The build output will be located at `build/app/outputs/flutter-apk/` (APK) or `build/app/outputs/bundle/` (AAB).

### iOS

```sh
# (macOS only)
flutter build ios --release
```

### Web

```sh
flutter build web
```

### Desktop (Linux / Windows / macOS)

```sh
flutter build linux
flutter build windows
flutter build macos
```

## Tests

```sh
flutter test
```

## Useful commands

```sh
flutter analyze        # Run the static analyzer
flutter doctor         # Verify your Flutter setup
```
