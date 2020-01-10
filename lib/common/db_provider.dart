import 'dart:io';

import 'package:jsos_helper/models/calendar_event.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  static const CREATE_CALENDAR_EVENT_TABLE = 'CREATE TABLE calendar_event ('
      'id INTEGER PRIMARY KEY,'
      'name TEXT,'
      'classroom TEXT,'
      'lecturer TEXT,'
      'start_date_time DATETIME,'
      'end_date_time DATETIME,'
      'event_type INTEGER'
      ');';

  static const CREATE_GRADE_TABLE = 'CREATE TABLE grade ('
      'id INTEGER PRIMARY KEY,'
      'value INTEGER,'
      'ects INTEGER,'
      'class_name TEXT,'
      'date DATETIME,'
      'lecturer TEXT,'
      'semester INTEGER,'
      'event_type INTEGER'
      ');';

  static const CREATE_MESSAGE_TABLE = 'CREATE TABLE message ('
      'id INTEGER PRIMARY KEY,'
      'from TEXT,'
      'to TEXT,'
      'cc TEXT,'
      'subject TEXT,'
      'content TEXT,'
      'date DATETIME,'
      ');';

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'jsosHelper.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(CREATE_CALENDAR_EVENT_TABLE);
      await db.execute(CREATE_GRADE_TABLE);
      await db.execute(CREATE_MESSAGE_TABLE);

//    TODO - add some sample data
      var events = [
        {
          'name': 'Internetowe bazy danych',
          'classroom': 'C-16, s. L2.6',
          'lecturer': 'Dr inż. Roman Ptak',
          'start_date_time': DateTime(2020, 1, 1, 9, 15).toString(),
          'end_date_time': DateTime(2020, 1, 1, 12).toString(),
          'event_type': EventType.project.index
        },
        {
          'name': 'Bezp. syst. i usług inform. 2',
          'classroom': 'C-3, s. 013',
          'lecturer': 'Mgr inż. Przemysław Świercz',
          'start_date_time': DateTime(2020, 1, 1, 11, 15).toString(),
          'end_date_time': DateTime(2020, 1, 1, 14).toString(),
          'event_type': EventType.laboratory.index
        },
        // TODO - add first and last day of the month, create more than one event during a day
      ];
      events.forEach((event) => db.insert('calendar_event', event));
    });
  }
}
