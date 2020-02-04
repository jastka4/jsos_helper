import 'package:jsos_helper/common/connection_status_singleton.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/dao/calendar_dao.dart';
import 'package:jsos_helper/models/calendar_event.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:jsos_helper/services/calendar_service.dart';
import 'package:meta/meta.dart';

class CalendarRepository {
  final CalendarDao _calendarDao = CalendarDao();
  final CalendarService _calendarService = CalendarService();
  final StorageRepository storageRepository;

  CalendarRepository({@required this.storageRepository});

  Future<List<CalendarEvent>> getAllCalendarEvents() =>
      _calendarDao.getAllCalendarEvents();

  Future<List<CalendarEvent>> getCalendarEvents(
      DateTime first, DateTime last) async {
    String _username = await storageRepository.getUsername();
    University _university = await storageRepository.getUniversity();
    if (await ConnectionStatusSingleton.getInstance().checkConnection()) {
      List<CalendarEvent> events = await _calendarService.fetchCalendarEvents(
          _username, _university, first, last);
      _calendarDao.updateCalendarEvents(first, last, events);
      return events;
    } else {
      return _calendarDao.getCalendarEvents(first, last);
    }
  }

  newCalendarEvent(CalendarEvent calendarEvent) =>
      _calendarDao.newCalendarEvent(calendarEvent);
}
