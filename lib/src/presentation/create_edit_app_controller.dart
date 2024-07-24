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
  @override
  // ignore:no-empty-block
  FutureOr<void> build() async {
    // no-op
  }

  Future<void> createOrEditApp(App? existingApp, String newName) async {
    final db = ref.read(appDatabaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // * Update the DB
      if (existingApp != null) {
        await db.editAppName(appId: existingApp.id, newName: newName);
      } else {
        await db.createNewApp(name: newName);
      }
      // TODO: Analytics
    });
  }

  Future<void> deleteAppById(int appId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(appDatabaseProvider).deleteAppById(appId);
      // TODO: Analytics
    });
  }
}
