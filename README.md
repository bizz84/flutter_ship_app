# Flutter Ship App

This is the companion app for my course about Flutter in production.

You can preview the app here:

- [Flutter Ship App - web demo](https://bizz84.github.io/flutter_ship_app_web/)

## Cloning the repo

```zsh
git clone https://github.com/bizz84/flutter_ship_app
cd flutter_ship_app
flutter pub get
```

On certain lessons, I’ll ask you to checkout a specific branch so you can easily switch to the latest code. Example:

```zsh
git switch m05-starter
```

### Multiple flavors

The app uses three separate flavors: `dev`, `stg`, and `prod`. These are already configured if you grab the latest code.

### Configuring Firebase with FlutterFire CLI

The project uses Firebase Analytics and Remote Config. As such, it needs to be configured with the FlutterFire CLI as shown in [this lesson](https://pro.codewithandrea.com/flutter-in-production/03-flavors/16-firebase-setup-flutterfire-cli).

To make life easier, run the `flutterfire-config.sh` script for each flavor:

```zsh
./flutterfire-config.sh dev
# Follow steps in interactive prompt
./flutterfire-config.sh stg
# Follow steps in interactive prompt
./flutterfire-config.sh prod
# Follow steps in interactive prompt
```

### Setting the Sentry and Mixpanel keys

This project uses some `.env` files to store the Sentry and Mixpanel keys. Before you can run the app, create these empty files:

- `.env.dev`
- `.env.stg`
- `.env.prod`

Upon startup, the app will read the `SENTRY_DSN` and `MIXPANEL_PROJECT_TOKEN` from these files using `--dart-define-from-file`.

If those values are missing or empty, the app will still run, but won't be sending data to Sentry and Mixpanel.

To configure them correctly, you need to:

- Create a Sentry project as [explained here](https://pro.codewithandrea.com/flutter-in-production/04-error-monitoring/03-sentry-installation)
- Go to [sentry.io](https://sentry.io/) and grab the Sentry DSN from **[Project] > Settings > Client Keys**
- Create a Mixpanel project **for each flavor** as [explained here](https://pro.codewithandrea.com/flutter-in-production/05-analytics/11-mixpanel-project-setup)
- Go to the Access Keys section of the [project's settings page](https://mixpanel.com/settings/project/) and grab the Mixpanel project token

Then, store the `SENTRY_DSN` and `MIXPANEL_PROJECT_TOKEN` inside `.env.dev`, `.env.stg`, `.env.prod`:

```zsh
# Go to sentry.io and grab the Sentry DSN from [Project] > Settings > Client Keys
SENTRY_DSN=https://examplePublicKey@o0.ingest.us.sentry.io/your-dsn
# Go to https://mixpanel.com/settings/project/ and grab the Mixpanel project token from the Access Keys section
MIXPANEL_PROJECT_TOKEN=your-mixpanel-project-token-dev
```

### Note about Flutter Web

To make the app run on Flutter web, I followed some of the steps in [the Drift web guide](https://drift.simonbinder.eu/web/):

- Include the `sqlite3.wasm` file ([v2.4.3](https://github.com/simolus3/sqlite3.dart/releases/tag/sqlite3-2.4.3)) from the [Sqlite3 releases page](https://github.com/simolus3/sqlite3.dart/releases)
- Include the `drift_worker.js` file ([v2.18.0](https://github.com/simolus3/drift/releases/tag/drift-2.18.0)) from the [Drift releases page](https://github.com/simolus3/drift/releases)
- Used conditional imports in the [app_database.dart](lib/src/data/app_database.dart) file, following the same approach used by the [Drift example app](https://github.com/simolus3/drift/tree/develop/examples/app)


### [LICENSE: MIT](LICENSE.md)