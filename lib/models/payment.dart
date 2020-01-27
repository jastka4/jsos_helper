import 'package:flutter/cupertino.dart';

enum PaymentStatus { open, pending, overdue, complete }

class Payment {
  final int id;
  final double value;
  final String title;
  final String description;
  final int instalment;
  final DateTime paymentDate;
  final DateTime issueDate;
  final PaymentStatus status;

  Payment({
    this.id,
    this.issueDate,
    this.instalment,
    @required this.value,
    @required this.title,
    @required this.description,
    @required this.paymentDate,
    @required this.status,
  });

  factory Payment.fromMap(Map<String, dynamic> json) => new Payment(
        id: json["id"],
        value: json["value"],
        title: json["title"],
        description: json["description"],
        instalment: int.parse(json["instalment"]),
        paymentDate: DateTime.parse(json["paymentDate"]),
        issueDate: DateTime.parse(json["issueDate"]),
        status: PaymentStatus.values[int.parse(json["status"])],
      );

  factory Payment.fromJson(Map<String, dynamic> json) => new Payment(
        value: double.parse(json["value"]),
        title: json["title"],
        description: json["description"],
        instalment:
            json["instalment"] != null ? int.parse(json["instalment"]) : null,
        paymentDate: DateTime.parse(json["paymentDate"]),
        issueDate: DateTime.parse(json["issueDate"]),
        status: PaymentStatus.values[int.parse(json["status"])],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "value": value,
        "title": title,
        "description": description,
        "instalment": instalment,
        "paymentDate": paymentDate,
        "issueDate": issueDate,
        "status": status,
      };

  @override
  String toString() {
    return 'Payment{id: $id, value: $value, title: $title, description: $description, instalment: $instalment, paymentDate: $paymentDate, issueDate: $issueDate, status: $status}';
  }
}
