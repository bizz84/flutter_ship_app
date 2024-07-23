import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/domain/app.dart';
import 'package:flutter_ship_app/src/monitoring/analytics_facade.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_edit_app_controller.g.dart';

@riverpod
class CreateEditAppController extends _$CreateEditAppController {
  @override
  // ignore:no-empty-block
  FutureOr<void> build() async {
    // no-op
  }

  Future<void> createOrEditApp(App? existingApp, String newName) async {
    final db = ref.read(appDatabaseProvider);
    state = await AsyncValue.guard(() async {
      // * Update the DB
      if (existingApp != null) {
        await db.editAppName(appId: existingApp.id, newName: newName);
      } else {
        await db.createNewApp(name: newName);
      }
      // * Analytics code
      if (existingApp != null) {
        ref.read(analyticsFacadeProvider).trackEditApp();
      } else {
        ref.read(analyticsFacadeProvider).trackCreateApp();
      }
    });
  }

  Future<void> deleteAppById(int appId) async {
    await ref.read(appDatabaseProvider).deleteAppById(appId);
    ref.read(analyticsFacadeProvider).trackDeleteApp();
  }
}
