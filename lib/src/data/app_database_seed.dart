import 'package:drift/drift.dart';
import 'package:flutter_ship_app/env/flavor.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';

const _seedData = [
  {
    "appName": "Flutter Tips",
    "tasks": [
      // App Icons
      "7DA5766A",
      "029C2183",
      "785BF2FB",
      "0A5EEB63",
      "8678BA0A",
      // Flutter Flavors
      "FE3F6F6D",
      "B2A42464",
      "C9FB1D58",
      "8301150C",
      "C4F3EEAA",
      "D88C0DA4",
      // Error Monitoring
      "0836A3B0",
      "6FEC4658",
      "56EAA140",
      "440585FB",
      "3BF7C4FB",
      "2C2C7454",
      "75644300",
      "1CCBEB7B",
      "1F7504F6",
      // Analytics
      "364BC976",
      "0B203CD9",
      "DFB4257F",
      "BD661A58",
      "28C7E044",
      "1E8213E6",
      "E873F9CE",
      // Force Update
      "062D761A",
      "6DAE72DE",
      "E6A45538",
      "7232501C",
      "9043CEA1",
      // Kill Switch
      // In App Review Prompt
      "69D3754B",
      "07EBB554",
      "B9EFA364",
      "1710AAC8",
      // Create your App Website
      "E1D761CF",
      "6EEE2634",
      "9712573F",
      "917B1F0C",
      "DCFBB2F9",
      // About / Settings page
      "9AB92F0F",
      "869E57CA",
      // Accessibility
      "CF6E07E1",
      "CAF5B3BB",
      "2AC342E8",
      "89F155C3",
    ]
  },
  {
    "appName": "Pixel Picker",
    "tasks": [
      // App Icons
      "7DA5766A",
      "029C2183",
      "785BF2FB",
      "0A5EEB63",
      "8678BA0A",
      // Flutter Flavors
      // Error Monitoring
      // Analytics
      // Force Update
      "062D761A",
      "6DAE72DE",
      "E6A45538",
      "7232501C",
      "9043CEA1",
      // Kill Switch
      // In App Review Prompt
      // Create your App Website
      // About / Settings page
      "9AB92F0F",
      "869E57CA",
      "A5DD4B1E",
      // Accessibility
    ]
  },
  {
    "appName": "Habit Tracker",
    "tasks": [
      // App Icons
      "7DA5766A",
      "029C2183",
      "785BF2FB",
      "0A5EEB63",
      "8678BA0A",
      // Flutter Flavors
      // Error Monitoring
      // Analytics
      // Force Update
      // Kill Switch
      // In App Review Prompt
      // Create your App Website
      // About / Settings page
      "9AB92F0F",
      "869E57CA",
      "A5DD4B1E",
      // Accessibility
    ]
  },
  {
    "appName": "Flutter Ship",
    "tasks": [
      // App Icons
      "7DA5766A",
      "029C2183",
      "785BF2FB",
      "0A5EEB63",
      "8678BA0A",
      // Flutter Flavors
      "FE3F6F6D",
      "B2A42464",
      "C9FB1D58",
      "8301150C",
      "C4F3EEAA",
      "D88C0DA4",
      // Error Monitoring
      "0836A3B0",
      "6FEC4658",
      "56EAA140",
      "440585FB",
      "3BF7C4FB",
      "2C2C7454",
      "75644300",
      "1CCBEB7B",
      "1F7504F6",
      // Analytics
      "364BC976",
      "0B203CD9",
      "DFB4257F",
      "BD661A58",
      "28C7E044",
      "1E8213E6",
      "E873F9CE",
      "5A1AF839",
      // Force Update
      "062D761A",
      "6DAE72DE",
      "E6A45538",
      "7232501C",
      "9043CEA1",
      // Kill Switch
      "981E81A1",
      "6FFFA770",
      "D48D8732",
      "3CE42C25",
      "DF8E533F",
      // In App Review Prompt
      "69D3754B",
      "07EBB554",
      "B9EFA364",
      "1710AAC8",
      "A1D55FA9",
      // Create your App Website
      "E1D761CF",
      "6EEE2634",
      "9712573F",
      "917B1F0C",
      "DCFBB2F9",
      "73C526B8",
      "5258B296",
      "79F5D584",
      // About / Settings page
      "9AB92F0F",
      "869E57CA",
      "A5DD4B1E",
      // Accessibility
      "CF6E07E1",
      "CAF5B3BB",
      "2AC342E8",
      "89F155C3",
      "3A9D1367",
      "770600E2",
      "55B298EB",
      "B8664A67",
      "28D3222B",
    ]
  }
];

/// All the CRUD operations supported by the database
extension AppDatabaseSeed on AppDatabase {
  /// Seed the database with the default data
  Future<void> seedDatabase() async {
    assert(getFlavor() != Flavor.prod, 'Cannot seed database in prod');
    // * Seed the apps
    for (final seedApp in _seedData) {
      final appName = seedApp['appName'] as String;
      final appId = await into(apps).insert(AppsCompanion(
        name: Value(appName),
      ));
      final taskIds = seedApp['tasks'] as List<String>;
      for (final taskId in taskIds) {
        // * Seed the epics
        updateTaskCompletionStatus(
          appId: appId,
          taskId: taskId,
          isCompleted: true,
        );
      }
    }
  }
}
