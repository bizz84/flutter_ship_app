# flutter_ship_app

A new Flutter project.


### Note about Flutter Web

To make the app run on Flutter web, some additional steps have been followed from [this guide](https://drift.simonbinder.eu/web/#examples):

- Include the `sqlite3.wasm` file (v0.5.21) from the [Sqlite3 releases page](https://github.com/simolus3/sqlite3.dart/releases)
- Include the `drift_worker.js` file (v2.17.0) from the [Drift releases page](https://github.com/simolus3/drift/releases)
- Used conditional imports in the [app_database.dart](lib/src/data/app_database.dart) file, following the same approach used by the [Drift example app](https://github.com/simolus3/drift/tree/develop/examples/app)


