import 'dart:io';

import 'package:jsos_helper/models/calendar_event.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

var events = [
  CalendarEvent(
      name: 'Internetowe bazy danych',
      classroom: 'C-16, s. L2.6',
      lecturer: 'Dr inż. Roman Ptak',
      startDateTime: DateTime(2020, 1, 1, 9, 15),
      endDateTime: DateTime(2020, 1, 1, 12),
      eventType: EventType.project),
  CalendarEvent(
      name: 'Bezp. syst. i usług inform. 2',
      classroom: 'C-3, s. 013',
      lecturer: 'Mgr inż. Przemysław Świercz',
      startDateTime: DateTime(2020, 1, 1, 11, 15),
      endDateTime: DateTime(2020, 1, 1, 14),
      eventType: EventType.project)
];

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "jsosHelper.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE calendar_event ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "classroom TEXT,"
              "lecturer TEXT,"
              "start_date_time DATETIME,"
              "end_date_time DATETIME,"
              "event_type INTEGER"
              ")");
//          newCalendarEvent(events[0]);
//          newCalendarEvent(events[1]);
        });
  }

  Future<List<CalendarEvent>> getAllCalendarEvents() async {
    final db = await database;
    var res = await db.query("calendar_event");
    List<CalendarEvent> list =
    res.isNotEmpty ? res.map((c) => CalendarEvent.fromMap(c)).toList() : [] as Map<DateTime, List>;
    return list;
  }

  newCalendarEvent(CalendarEvent calendarEvent) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM calendar_event");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into calendar_event (id,name,lecturer,start_date_time,end_date_time,event_type)"
            " VALUES (?,?,?,?,?,?)",
        [
          id,
          calendarEvent.name,
          calendarEvent.lecturer,
          calendarEvent.startDateTime,
          calendarEvent.endDateTime,
          calendarEvent.eventType
        ]);
    return raw;
  }
}
