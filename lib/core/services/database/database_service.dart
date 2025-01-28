import 'dart:developer';

import '/core/constants/app_constants.dart';
import 'package:sqflite/sqflite.dart';

import 'alarm_model.dart';

class DatabaseService {
  late Database database;
  Future<void> init() async {
    database = await openDatabase(
      kDatabaseName,
      version: 1,
      onCreate: (Database db, int version) async {
        try {
          await db.execute(
            'CREATE TABLE $kDatabaseAlarmTable($kDatabaseColumnId INTEGER PRIMARY KEY, $kDatabaseColumnTitle TEXT, $kDatabaseColumnDescription TEXT, $kDatabaseColumnStatus TEXT, $kDatabaseColumnDate TEXT,$kDatabaseColumnWeekDay TEXT, $kDatabaseColumnTime TEXT, $kDatabaseColumnNumberPerTime INTEGER, $kDatabaseColumnType TEXT)',
          );
          log('Database Created', name: 'DatabaseService');
        } on Exception catch (e) {
          log(e.toString(), name: 'DatabaseService');
        }
      },
      onOpen: (db) {
        log('Database Opened', name: 'DatabaseService');
      },
      singleInstance: true,
    );
  }

  Future<int> insertAlarm(AlarmModel alarm) async {
    return await database.insert(kDatabaseAlarmTable, alarm.toMap());
  }

  Future<List<AlarmModel>> getAlarms() async {
    final List<Map<String, dynamic>> maps =
        await database.query(kDatabaseAlarmTable);
    return List.generate(maps.length, (index) {
      return AlarmModel.fromMap(maps[index]);
    });
  }

  Future<int> updateAlarm(AlarmModel alarm) async {
    log(alarm.status.name, name: 'DatabaseService');
    return await database.update(
      kDatabaseAlarmTable,
      alarm.toMap(),
      where: '$kDatabaseColumnId = ?',
      whereArgs: [alarm.id],
    );
  }

  Future<int> deleteAlarm(int id) async {
    return await database.delete(
      kDatabaseAlarmTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    await database.close();
  }

  Future<void> deleteAllAlarms() async {
    await database.delete(kDatabaseAlarmTable);
  }

  Future<List<AlarmModel>> getAlarmsByDate(String date) async {
    final List<Map<String, dynamic>> maps = await database.query(
      kDatabaseAlarmTable,
      where: '$kDatabaseColumnDate = ?',
      whereArgs: [date],
      orderBy: 'time',
    );
    log(maps.toString(), name: 'DatabaseService');
    return List.generate(maps.length, (index) {
      return AlarmModel.fromMap(maps[index]);
    });
  }

  Future<List<AlarmModel>> getAlarmsByStatus(String status) async {
    final List<Map<String, dynamic>> maps = await database.query(
      kDatabaseAlarmTable,
      where: 'status = ?',
      whereArgs: [status],
    );
    return List.generate(maps.length, (index) {
      return AlarmModel.fromMap(maps[index]);
    });
  }

  Future<List<AlarmModel>> getAlarmsByType(String type) async {
    final List<Map<String, dynamic>> maps = await database.query(
      kDatabaseAlarmTable,
      where: 'type = ?',
      whereArgs: [type],
    );
    return List.generate(maps.length, (index) {
      return AlarmModel.fromMap(maps[index]);
    });
  }

  Future<List<AlarmModel>> getAlarmsForDay(String date, String weekday) async {
    final List<Map<String, dynamic>> maps = await database.query(
      kDatabaseAlarmTable,
      where:
          '$kDatabaseColumnType = ? OR $kDatabaseColumnDate = ? OR ($kDatabaseColumnWeekDay = ? AND $kDatabaseColumnType = ?)',
      whereArgs: ["everyDay", date, weekday, "differentDays"],
    );
    return List.generate(maps.length, (index) {
      return AlarmModel.fromMap(maps[index]);
    });
  }
}
