## 0.3.8

- Updated `showAlertDialog` helper
- Updated `IPHONEOS_DEPLOYMENT_TARGET` to 13.0
- Updated to `flex_color_scheme` 8.2.0
- Updated to work with Flutter 3.32 beta

## 0.3.7

- Regenerate android project with Flutter 3.29 (new `.gradle.kts` syntax)
- Update to Drift 2.26.0
- Updated to latest packages

## 0.3.6

- Made project compatible with Flutter 3.29 (`path: ^1.9.0`)
- Update to Drift 2.25.2
- Cleanup `app_colors.dart`
- Bump platform, ios: '16.0'

## 0.3.5

- Move `AppStartupWidget` inside `MaterialApp.builder`
- Update to Drift 2.24.0

## 0.3.4

- Improved web support in `flavor.dart`
- Update to Drift 2.21.0
- Update to Riverpod 2.6.1
- Update to Gradle 8.9

## 0.3.3

- Settings page: show transparent icon and correct app name on web

## 0.3.2

- Update to Gradle 8.3

## 0.3.1

- Update to latest packages

## 0.3.0

- Delete `app_release_template.json` (this is now only loaded remotely)
- More robust app startup and DB initialization logic
- Set iOS 13.0 in Podfile

## 0.2.2

- Update to Dart 3.5, Flutter 3.24
- Update to latest packages

## 0.2.1

- Pass `settings` to `MaterialPageRoute` inside `onGenerateRoute`
- Split `createEditApp` into two routes: `createApp`, `editApp`
- Add `name`, `error`, `stackTrace` to `AppLogger`
- Rename `LoggerInterceptor` to `LoggerDioInterceptor` and move it to `monitoring` folder
- Add optional `routeName` argument to `showAlertDialog`
- Lightweight stateless `CreateEditAppController` and `TasksChecklistController`

## 0.2.0

- Update the app to use named routes (Navigator 1.0)
- Add `CreateEditAppController`, `TasksChecklistController`
- Cleanup lints

## 0.1.11

- Better error handling during app startup (see [#6](https://github.com/bizz84/flutter_ship_app/pull/6))

## 0.1.10

- Fix for offline mode (see [#5](https://github.com/bizz84/flutter_ship_app/pull/5))

## 0.1.9

- Apply DCM rules

## 0.1.8

- Updated `.gitignore` files
- Added flavor.dart
- Add `isCanvasKitRenderer()` helper

## 0.1.7

- Update Drift connection to use LazyDatabase (fixes app startup issue)

## 0.1.6

- Add Android adaptive icons
- Fix app startup issue due to missing asset in root bundle

## 0.1.5

- Updated app icon

## 0.1.4

- Small fixes for the app editing logic

## 0.1.3

- Added CSS loader to Flutter web initialization logic

## 0.1.2

- Updated to latest dependencies

## 0.1.1

- Updated `.gitignore`
- Recreated web project with Flutter 3.22

## 0.1.0

- Initial version