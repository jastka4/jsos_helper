import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  static const CREATE_USER_TABLE = 'CREATE TABLE user ('
      'id INTEGER PRIMARY KEY,'
      'username TEXT,'
      'full_name TEXT,'
      'student_number TEXT,'
      'faculty TEXT,'
      'subject TEXT,'
      'degree TEXT,'
      'specialization TEXT,'
      'university INTEGER,'
      'image BLOB'
      ');';

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

  static const CREATE_PAYMENT_TABLE = 'CREATE TABLE payment ('
      'id INTEGER PRIMARY KEY,'
      'value INTEGER,'
      'title TEXT,'
      'description TEXT,'
      'instalment INTEGER,'
      'paymentDate DATETIME,'
      'issueDate DATETIME,'
      'status INTEGER'
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
      await db.execute(CREATE_USER_TABLE);
      await db.execute(CREATE_CALENDAR_EVENT_TABLE);
      await db.execute(CREATE_GRADE_TABLE);
      await db.execute(CREATE_MESSAGE_TABLE);
      await db.execute(CREATE_PAYMENT_TABLE);
    });
  }
}
