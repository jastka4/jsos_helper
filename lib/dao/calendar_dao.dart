import 'package:intl/intl.dart';
import 'package:jsos_helper/common/db_provider.dart';
import 'package:jsos_helper/models/calendar_event.dart';

class CalendarDao {
  Future<List<CalendarEvent>> getAllCalendarEvents() async {
    final db = await DBProvider.db.database;
    var res = await db.query('calendar_event');
    List<CalendarEvent> list =
        res.isNotEmpty ? res.map((c) => CalendarEvent.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<CalendarEvent>> getCalendarEvents(
      DateTime start, DateTime end) async {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    final db = await DBProvider.db.database;
    var res = await db.query('calendar_event',
        where: 'start_date_time BETWEEN ? AND ?',
        whereArgs: [dateFormat.format(start), dateFormat.format(end)]);
    List<CalendarEvent> list =
        res.isNotEmpty ? res.map((c) => CalendarEvent.fromMap(c)).toList() : [];
    return list;
  }

  void updateCalendarEvents(
      DateTime start, DateTime end, List<CalendarEvent> calendarEvents) async {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    final db = await DBProvider.db.database;
    db.delete('calendar_event',
        where: 'start_date_time BETWEEN ? AND ?',
        whereArgs: [dateFormat.format(start), dateFormat.format(end)]);

    calendarEvents.forEach((event) => newCalendarEvent(event));
  }

  newCalendarEvent(CalendarEvent calendarEvent) async {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    final db = await DBProvider.db.database;
    var table = await db.rawQuery('SELECT MAX(id)+1 as id FROM calendar_event');
    int id = table.first['id'] != null ? table.first['id'] : 0;

    var raw = await db.rawInsert(
        'INSERT into calendar_event (id,name,classroom,lecturer,start_date_time,end_date_time,event_type)'
        ' VALUES (?,?,?,?,?,?,?)',
        [
          id,
          calendarEvent.name,
          calendarEvent.classroom,
          calendarEvent.lecturer,
          dateFormat.format(calendarEvent.startDateTime),
          dateFormat.format(calendarEvent.endDateTime),
          calendarEvent.eventType.index
        ]);
    return raw;
  }
}
