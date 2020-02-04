import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsos_helper/common/global_constants.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/models/calendar_event.dart';

class CalendarService {
  static const URL = GlobalConstants.BASE_API_URL + '/calendar';

  Future<List<CalendarEvent>> fetchCalendarEvents(String username,
      University university, DateTime start, DateTime end) async {
    final response = await http.post(URL,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'username': username,
            'university': university.abbreviation,
            'startDate': start.toIso8601String(),
            'endDate': end.toIso8601String(),
          },
        ));
    if (response.statusCode == 200) {
      return _parseCalendarEvents(response.body);
    } else {
      throw Exception('Unable to fetch calendar events from the REST API');
    }
  }

  List<CalendarEvent> _parseCalendarEvents(String responseBody) {
    final parsed = json.decode(responseBody)["events"];
    return parsed.isNotEmpty
        ? parsed
            .map<CalendarEvent>((json) => CalendarEvent.fromJson(json))
            .toList()
        : [];
  }
}
