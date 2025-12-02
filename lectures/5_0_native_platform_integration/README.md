# battery_level_example

Simple Flutter sample showing how to use a MethodChannel to get the battery
level from Android native code.

## How to use

1. Either:
   - Use this folder as your Flutter project root, then run `flutter create .`
     once to generate missing platform boilerplate, OR
   - Create a new Flutter project and copy `lib/main.dart` and
     `android/app/src/main/kotlin/com/example/battery_level_example/MainActivity.kt`
     into it.

2. Make sure the Android package name matches `com.example.battery_level_example`.
   If not, adjust the `package` line in `MainActivity.kt` and the folder path
   under `android/app/src/main/kotlin` accordingly.

3. From the project root, run:

```bash
flutter pub get
flutter run
```

On launch, the app will attempt to fetch and display the device battery level
via a platform channel.
