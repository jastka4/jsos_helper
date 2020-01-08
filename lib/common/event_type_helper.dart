import 'package:flutter/material.dart';
import 'package:jsos_helper/models/calendar_event.dart';

class EventTypeHelper {
  static Color getColor(EventType eventType) {
    switch (eventType) {
      case EventType.project:
        return Colors.cyan;
      case EventType.laboratory:
        return Colors.indigo;
      case EventType.lecture:
        return Colors.green;
      case EventType.practical:
        return Colors.amber;
      case EventType.seminar:
        return Colors.greenAccent;
      case EventType.other:
      default:
        return Colors.black;
    }
  }
}
