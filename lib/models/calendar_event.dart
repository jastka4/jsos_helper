import 'dart:convert';

import 'package:meta/meta.dart';

enum EventType { lecture, practical, laboratory, project, seminar, other }

CalendarEvent calendarEventFromJson(String str) {
  final jsonData = json.decode(str);
  return CalendarEvent.fromMap(jsonData);
}

String calendarEventToJson(CalendarEvent data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class CalendarEvent {
  final int id;
  final String name;
  final String classroom;
  final String lecturer;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final EventType eventType;

  CalendarEvent(
      {this.id,
      @required this.name,
      @required this.classroom,
      @required this.lecturer,
      @required this.startDateTime,
      @required this.endDateTime,
      @required this.eventType});

  factory CalendarEvent.fromMap(Map<String, dynamic> json) => new CalendarEvent(
        id: json["id"],
        name: json["name"],
        classroom: json["classroom"],
        lecturer: json["lecturer"],
        startDateTime: DateTime.parse(json["start_date_time"]),
        endDateTime: DateTime.parse(json["end_date_time"]),
        eventType: EventType.values[json["event_type"]],
      );

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      new CalendarEvent(
        name: json["name"],
        classroom: json["classroom"],
        lecturer: json["lecturer"],
        startDateTime: DateTime.parse(json["startDateTime"]),
        endDateTime: DateTime.parse(json["endDateTime"]),
        eventType: EventType.values[int.parse(json["eventType"])],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "classroom": classroom,
        "lecturer": lecturer,
        "start_date_time": startDateTime,
        "end_date_time": endDateTime,
        "event_type": eventType,
      };

  @override
  String toString() {
    return 'CalendarEvent{id: $id, name: $name, classroom: $classroom, lecturer: $lecturer, startDateTime: $startDateTime, endDateTime: $endDateTime, eventType: $eventType}';
  }
}
