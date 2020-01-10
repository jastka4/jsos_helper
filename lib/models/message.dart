import 'package:meta/meta.dart';

class Message {
  final int id;
  final String from;
  final String to;
  final String cc;
  final String subject;
  final String content;
  final DateTime date;

  Message(
      {this.id,
      this.cc,
      @required this.from,
      @required this.to,
      @required this.subject,
      @required this.content,
      @required this.date});

  factory Message.fromMap(Map<String, dynamic> json) => new Message(
        id: json["id"],
        from: json["from"],
        cc: json["cc"],
        to: json["to"],
        subject: json["subject"],
        content: json["content"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "from": from,
        "cc": cc,
        "to": to,
        "subject": subject,
        "content": content,
        "date": date,
      };

  @override
  String toString() {
    return 'Message{id: $id, from: $from, to: $to, cc: $cc, subject: $subject, content: $content, date: $date}';
  }
}
