import 'package:flutter/material.dart';
import 'package:jsos_helper/models/calendar_event.dart';
import 'package:jsos_helper/models/payment.dart';

class ColorHelper {
  static Color getEventColor(EventType eventType) {
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

// TODO - get event type name by language

  static Color getPaymentColor(PaymentStatus paymentStatus) {
    switch (paymentStatus) {
      case PaymentStatus.pending:
        return Colors.indigo;
      case PaymentStatus.complete:
        return Colors.green;
      case PaymentStatus.overdue:
        return Colors.red;
      case PaymentStatus.open:
      default:
        return Colors.grey;
    }
  }
}
