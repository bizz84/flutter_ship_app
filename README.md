# Flutter Ship App

This is the companion app for my course about Flutter in production.

You can preview the app here:

- [Flutter Ship App - web demo](https://bizz84.github.io/flutter_ship_app_web/)

### Note about Flutter Web

To make the app run on Flutter web, I followed some of the steps in [the Drift web guide](https://drift.simonbinder.eu/web/):

- Include the `sqlite3.wasm` file ([v2.4.3](https://github.com/simolus3/sqlite3.dart/releases/tag/sqlite3-2.4.3)) from the [Sqlite3 releases page](https://github.com/simolus3/sqlite3.dart/releases)
- Include the `drift_worker.js` file ([v2.18.0](https://github.com/simolus3/drift/releases/tag/drift-2.18.0)) from the [Drift releases page](https://github.com/simolus3/drift/releases)
- Used conditional imports in the [app_database.dart](lib/src/data/app_database.dart) file, following the same approach used by the [Drift example app](https://github.com/simolus3/drift/tree/develop/examples/app)


### [LICENSE: MIT](LICENSE.md)