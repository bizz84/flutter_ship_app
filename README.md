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

The project uses Firebase Analytics and Remote Config. As such, it needs to be configured with the FlutterFire CLI as shown in [this lesson](https://pro.codewithandrea.com/flutter-in-production/03-flavors/18-firebase-setup-flutterfire-cli).

To make life easier, run this:

```zsh
# flutterfire-config.sh is gitignored
cp flutterfire-config-template.sh flutterfire-config.sh
```

Then, edit the `flutterfire-config.sh` file to set the correct Firebase project ID for each flavor (Firebase project IDs are globally unique).

Finally, run the `flutterfire-config.sh` script for each flavor:

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

### Setting the App Store ID

In order for the [force_update_helper](https://pub.dev/packages/force_update_helper) and [in_app_review](https://pub.dev/packages/in_app_review) packages to be correctly configured, the App Store ID should also be set in the `.env` files:

```zsh
APP_STORE_ID=<app-store-id>
```

This can be found on your app's page in App Store Connect under **General > App Information > Apple ID**.

See [this lesson](https://pro.codewithandrea.com/flutter-in-production/06-force-update/04-force-update-helper-package) for more info.

### Note about Flutter Web

To make the app run on Flutter web, I followed some of the steps in [the Drift web guide](https://drift.simonbinder.eu/web/):

- Include the `sqlite3.wasm` file from the [Sqlite3 releases page](https://github.com/simolus3/sqlite3.dart/releases)
- Include the `drift_worker.js` file from the [Drift releases page](https://github.com/simolus3/drift/releases)
- Used conditional imports in the [app_database.dart](lib/src/data/app_database.dart) file, following the same approach used by the [Drift example app](https://github.com/simolus3/drift/tree/develop/examples/app)

### [LICENSE: MIT](LICENSE.md)