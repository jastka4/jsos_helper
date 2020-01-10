import 'package:jsos_helper/models/calendar_event.dart';
import 'package:meta/meta.dart';

class Grade {
  final int id;
  final double value;
  final int ects;
  final String className;
  final String classroom;
  final String lecturer;
  final int semester;
  final EventType eventType;

  Grade(
      {this.id,
      this.classroom,
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
        classroom: json["classroom"],
        lecturer: json["lecturer"],
        semester: json["semester"],
        eventType: EventType.values[json["event_type"]],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "value": value,
        "ects": ects,
        "class_name": className,
        "classroom": classroom,
        "lecturer": lecturer,
        "semester": semester,
        "event_type": eventType,
      };

  @override
  String toString() {
    return 'Grade{id: $id, value: $value, ects: $ects, className: $className, classroom: $classroom, lecturer: $lecturer, semester: $semester, eventType: $eventType}';
  }
}
