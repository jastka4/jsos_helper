import 'package:jsos_helper/dao/calendar_dao.dart';
import 'package:jsos_helper/models/calendar_event.dart';

class CalendarRepository {
  final CalendarDao _calendarDao = CalendarDao();

  Future<List<CalendarEvent>> getAllCalendarEvents() =>
      _calendarDao.getAllCalendarEvents();

  Future<List<CalendarEvent>> getCalendarEvents(
          DateTime first, DateTime last) =>
      _calendarDao.getCalendarEvents(first, last);

  newCalendarEvent(CalendarEvent calendarEvent) =>
      _calendarDao.newCalendarEvent(calendarEvent);
}
