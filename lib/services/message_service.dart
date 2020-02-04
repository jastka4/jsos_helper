import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsos_helper/common/global_constants.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/models/message.dart';

class MessageService {
  static const URL = GlobalConstants.BASE_API_URL + '/messages';

  Future<List<Message>> fetchMessages(
      String username, University university) async {
    final response = await http.post(
      URL,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'username': username,
          'university': university.abbreviation,
        },
      ),
    );
    if (response.statusCode == 200) {
      return _parseMessages(response.body);
    } else {
      throw Exception('Unable to fetch messages from the REST API');
    }
  }

  List<Message> _parseMessages(String responseBody) {
    final parsed = json.decode(responseBody)["messages"];
    return parsed.isNotEmpty
        ? parsed.map<Message>((i) => Message.fromJson(i)).toList()
        : [];
  }
}
