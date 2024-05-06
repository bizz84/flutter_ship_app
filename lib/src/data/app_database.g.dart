// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppsTableTable extends AppsTable
    with TableInfo<$AppsTableTable, AppData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apps_table';
  @override
  VerificationContext validateIntegrity(Insertable<AppData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $AppsTableTable createAlias(String alias) {
    return $AppsTableTable(attachedDatabase, alias);
  }
}

class AppData extends DataClass implements Insertable<AppData> {
  final int id;
  final String name;
  const AppData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  AppsTableCompanion toCompanion(bool nullToAbsent) {
    return AppsTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory AppData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  AppData copyWith({int? id, String? name}) => AppData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('AppData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppData && other.id == this.id && other.name == this.name);
}

class AppsTableCompanion extends UpdateCompanion<AppData> {
  final Value<int> id;
  final Value<String> name;
  const AppsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  AppsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<AppData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  AppsTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return AppsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $EpicsTableTable extends EpicsTable
    with TableInfo<$EpicsTableTable, EpicData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EpicsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 8),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, order, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'epics_table';
  @override
  VerificationContext validateIntegrity(Insertable<EpicData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EpicData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EpicData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $EpicsTableTable createAlias(String alias) {
    return $EpicsTableTable(attachedDatabase, alias);
  }
}

class EpicData extends DataClass implements Insertable<EpicData> {
  final String id;
  final int order;
  final String name;
  const EpicData({required this.id, required this.order, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order'] = Variable<int>(order);
    map['name'] = Variable<String>(name);
    return map;
  }

  EpicsTableCompanion toCompanion(bool nullToAbsent) {
    return EpicsTableCompanion(
      id: Value(id),
      order: Value(order),
      name: Value(name),
    );
  }

  factory EpicData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EpicData(
      id: serializer.fromJson<String>(json['id']),
      order: serializer.fromJson<int>(json['order']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'order': serializer.toJson<int>(order),
      'name': serializer.toJson<String>(name),
    };
  }

  EpicData copyWith({String? id, int? order, String? name}) => EpicData(
        id: id ?? this.id,
        order: order ?? this.order,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('EpicData(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, order, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EpicData &&
          other.id == this.id &&
          other.order == this.order &&
          other.name == this.name);
}

class EpicsTableCompanion extends UpdateCompanion<EpicData> {
  final Value<String> id;
  final Value<int> order;
  final Value<String> name;
  final Value<int> rowid;
  const EpicsTableCompanion({
    this.id = const Value.absent(),
    this.order = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EpicsTableCompanion.insert({
    required String id,
    required int order,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        order = Value(order),
        name = Value(name);
  static Insertable<EpicData> custom({
    Expression<String>? id,
    Expression<int>? order,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (order != null) 'order': order,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EpicsTableCompanion copyWith(
      {Value<String>? id,
      Value<int>? order,
      Value<String>? name,
      Value<int>? rowid}) {
    return EpicsTableCompanion(
      id: id ?? this.id,
      order: order ?? this.order,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EpicsTableCompanion(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTableTable extends TasksTable
    with TableInfo<$TasksTableTable, TaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 8),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _epicIdMeta = const VerificationMeta('epicId');
  @override
  late final GeneratedColumn<String> epicId = GeneratedColumn<String>(
      'epic_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 8),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES epics_table(id)');
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, epicId, order, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks_table';
  @override
  VerificationContext validateIntegrity(Insertable<TaskData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('epic_id')) {
      context.handle(_epicIdMeta,
          epicId.isAcceptableOrUnknown(data['epic_id']!, _epicIdMeta));
    } else if (isInserting) {
      context.missing(_epicIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      epicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}epic_id'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $TasksTableTable createAlias(String alias) {
    return $TasksTableTable(attachedDatabase, alias);
  }
}

class TaskData extends DataClass implements Insertable<TaskData> {
  final String id;
  final String epicId;
  final int order;
  final String name;
  const TaskData(
      {required this.id,
      required this.epicId,
      required this.order,
      required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['epic_id'] = Variable<String>(epicId);
    map['order'] = Variable<int>(order);
    map['name'] = Variable<String>(name);
    return map;
  }

  TasksTableCompanion toCompanion(bool nullToAbsent) {
    return TasksTableCompanion(
      id: Value(id),
      epicId: Value(epicId),
      order: Value(order),
      name: Value(name),
    );
  }

  factory TaskData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskData(
      id: serializer.fromJson<String>(json['id']),
      epicId: serializer.fromJson<String>(json['epicId']),
      order: serializer.fromJson<int>(json['order']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'epicId': serializer.toJson<String>(epicId),
      'order': serializer.toJson<int>(order),
      'name': serializer.toJson<String>(name),
    };
  }

  TaskData copyWith({String? id, String? epicId, int? order, String? name}) =>
      TaskData(
        id: id ?? this.id,
        epicId: epicId ?? this.epicId,
        order: order ?? this.order,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('TaskData(')
          ..write('id: $id, ')
          ..write('epicId: $epicId, ')
          ..write('order: $order, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, epicId, order, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskData &&
          other.id == this.id &&
          other.epicId == this.epicId &&
          other.order == this.order &&
          other.name == this.name);
}

class TasksTableCompanion extends UpdateCompanion<TaskData> {
  final Value<String> id;
  final Value<String> epicId;
  final Value<int> order;
  final Value<String> name;
  final Value<int> rowid;
  const TasksTableCompanion({
    this.id = const Value.absent(),
    this.epicId = const Value.absent(),
    this.order = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksTableCompanion.insert({
    required String id,
    required String epicId,
    required int order,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        epicId = Value(epicId),
        order = Value(order),
        name = Value(name);
  static Insertable<TaskData> custom({
    Expression<String>? id,
    Expression<String>? epicId,
    Expression<int>? order,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (epicId != null) 'epic_id': epicId,
      if (order != null) 'order': order,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? epicId,
      Value<int>? order,
      Value<String>? name,
      Value<int>? rowid}) {
    return TasksTableCompanion(
      id: id ?? this.id,
      epicId: epicId ?? this.epicId,
      order: order ?? this.order,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (epicId.present) {
      map['epic_id'] = Variable<String>(epicId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksTableCompanion(')
          ..write('id: $id, ')
          ..write('epicId: $epicId, ')
          ..write('order: $order, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskStatusesTableTable extends TaskStatusesTable
    with TableInfo<$TaskStatusesTableTable, TaskStatusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskStatusesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _appIdMeta = const VerificationMeta('appId');
  @override
  late final GeneratedColumn<int> appId = GeneratedColumn<int>(
      'app_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES apps_table(id)');
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 8),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES tasks_table(id)');
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [appId, taskId, completed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_statuses_table';
  @override
  VerificationContext validateIntegrity(Insertable<TaskStatusData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('app_id')) {
      context.handle(
          _appIdMeta, appId.isAcceptableOrUnknown(data['app_id']!, _appIdMeta));
    } else if (isInserting) {
      context.missing(_appIdMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {taskId, appId};
  @override
  TaskStatusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskStatusData(
      appId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}app_id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
    );
  }

  @override
  $TaskStatusesTableTable createAlias(String alias) {
    return $TaskStatusesTableTable(attachedDatabase, alias);
  }
}

class TaskStatusData extends DataClass implements Insertable<TaskStatusData> {
  final int appId;
  final String taskId;
  final bool completed;
  const TaskStatusData(
      {required this.appId, required this.taskId, required this.completed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['app_id'] = Variable<int>(appId);
    map['task_id'] = Variable<String>(taskId);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  TaskStatusesTableCompanion toCompanion(bool nullToAbsent) {
    return TaskStatusesTableCompanion(
      appId: Value(appId),
      taskId: Value(taskId),
      completed: Value(completed),
    );
  }

  factory TaskStatusData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskStatusData(
      appId: serializer.fromJson<int>(json['appId']),
      taskId: serializer.fromJson<String>(json['taskId']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'appId': serializer.toJson<int>(appId),
      'taskId': serializer.toJson<String>(taskId),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  TaskStatusData copyWith({int? appId, String? taskId, bool? completed}) =>
      TaskStatusData(
        appId: appId ?? this.appId,
        taskId: taskId ?? this.taskId,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('TaskStatusData(')
          ..write('appId: $appId, ')
          ..write('taskId: $taskId, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(appId, taskId, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskStatusData &&
          other.appId == this.appId &&
          other.taskId == this.taskId &&
          other.completed == this.completed);
}

class TaskStatusesTableCompanion extends UpdateCompanion<TaskStatusData> {
  final Value<int> appId;
  final Value<String> taskId;
  final Value<bool> completed;
  final Value<int> rowid;
  const TaskStatusesTableCompanion({
    this.appId = const Value.absent(),
    this.taskId = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskStatusesTableCompanion.insert({
    required int appId,
    required String taskId,
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : appId = Value(appId),
        taskId = Value(taskId);
  static Insertable<TaskStatusData> custom({
    Expression<int>? appId,
    Expression<String>? taskId,
    Expression<bool>? completed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (appId != null) 'app_id': appId,
      if (taskId != null) 'task_id': taskId,
      if (completed != null) 'completed': completed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskStatusesTableCompanion copyWith(
      {Value<int>? appId,
      Value<String>? taskId,
      Value<bool>? completed,
      Value<int>? rowid}) {
    return TaskStatusesTableCompanion(
      appId: appId ?? this.appId,
      taskId: taskId ?? this.taskId,
      completed: completed ?? this.completed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (appId.present) {
      map['app_id'] = Variable<int>(appId.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskStatusesTableCompanion(')
          ..write('appId: $appId, ')
          ..write('taskId: $taskId, ')
          ..write('completed: $completed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $AppsTableTable appsTable = $AppsTableTable(this);
  late final $EpicsTableTable epicsTable = $EpicsTableTable(this);
  late final $TasksTableTable tasksTable = $TasksTableTable(this);
  late final $TaskStatusesTableTable taskStatusesTable =
      $TaskStatusesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [appsTable, epicsTable, tasksTable, taskStatusesTable];
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'3d3a397d2ea952fc020fce0506793a5564e93530';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppDatabaseRef = ProviderRef<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
