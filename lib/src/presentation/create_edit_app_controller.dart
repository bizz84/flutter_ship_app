import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/domain/app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_edit_app_controller.g.dart';

/// Helper controller class for the CreateEditAppScreen widget.
/// This class holds the business logic for creating, editing, and deleting apps
/// using the underlying AppDatabase class for data persistence.
/// More info here: https://codewithandrea.com/articles/flutter-presentation-layer/
@riverpod
class CreateEditAppController extends _$CreateEditAppController {
  // * This controller is stateless and doesn't require any initialization.
  // * It performs mutations, but does not set the UI state or handle errors,
  // * because local DB operations are fast and unlikely to fail.
  @override
  void build() {
    // no-op
  }

  Future<void> createOrEditApp(App? existingApp, String newName) async {
    final db = ref.read(appDatabaseProvider);
    // * Update the DB
    if (existingApp != null) {
      await db.editAppName(appId: existingApp.id, newName: newName);
    } else {
      await db.createNewApp(name: newName);
    }
    // TODO: Analytics
  }

  Future<void> deleteAppById(int appId) async {
    await ref.read(appDatabaseProvider).deleteAppById(appId);
    // TODO: Analytics
  }
}

// ignore_for_file:no-empty-block

