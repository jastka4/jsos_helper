import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:jsos_helper/models/message.dart';

class MessageDetailsScreen extends StatelessWidget {
  final Message message;

  MessageDetailsScreen({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat _formatter = DateFormat("dd.MM.yyyy HH:mm:ss");
    // TODO - use DefaultTextStyle.of(context).style,
    final TextStyle _defaultStyle = TextStyle(color: Colors.black);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: _defaultStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: 'From: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: message.from)
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: _defaultStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: 'To: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: message.to)
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: _defaultStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Cc: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: message.cc)
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(message.subject,
                style: TextStyle(
                  fontSize: 18,
                )),
            Text(_formatter.format(message.date)),
            Divider(),
            Text(message.content),
          ],
        ),
      ),
    );
  }
}
