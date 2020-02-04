import 'package:jsos_helper/models/calendar_event.dart';
import 'package:meta/meta.dart';

class Grade {
  final int id;
  final double value;
  final int ects;
  final String className;
  final DateTime date;
  final String lecturer;
  final int semester;
  final EventType eventType;

  Grade(
      {this.id,
      this.date,
      @required this.value,
      @required this.ects,
      @required this.className,
      @required this.lecturer,
      @required this.semester,
      @required this.eventType});

  factory Grade.fromMap(Map<String, dynamic> json) => new Grade(
        id: json["id"],
        value: json["value"],
        ects: json["ects"],
        className: json["class_name"],
        date: DateTime.parse(json["date"]),
        lecturer: json["lecturer"],
        semester: json["semester"],
        eventType: EventType.values[json["event_type"]],
      );

  factory Grade.fromJson(Map<String, dynamic> json) => new Grade(
        value: double.parse(json["value"]),
        ects: int.parse(json["ects"]),
        className: json["className"],
        date: DateTime.parse(json["date"]),
        lecturer: json["lecturer"],
        semester: int.parse(json["semester"]),
        eventType: EventType.values[int.parse(json["eventType"])],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "value": value,
        "ects": ects,
        "class_name": className,
        "date": date,
        "lecturer": lecturer,
        "semester": semester,
        "event_type": eventType,
      };

  @override
  String toString() {
    return 'Grade{id: $id, value: $value, ects: $ects, className: $className, date: $date, lecturer: $lecturer, semester: $semester, eventType: $eventType}';
  }
}
