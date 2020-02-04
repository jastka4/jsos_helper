import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsos_helper/common/global_constants.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/models/grade.dart';

class GradeService {
  static const URL = GlobalConstants.BASE_API_URL + '/grades';

  Future<List<Grade>> fetchGrades(
      String username, University university) async {
    final response = await http.post(URL,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'username': username,
            'university': university.abbreviation,
          },
        ));
    if (response.statusCode == 200) {
      return _parseGrades(response.body);
    } else {
      throw Exception('Unable to fetch calendar events from the REST API');
    }
  }

  List<Grade> _parseGrades(String responseBody) {
    final parsed = json.decode(responseBody)["grades"];
    return parsed.isNotEmpty
        ? parsed.map<Grade>((i) => Grade.fromJson(i)).toList()
        : [];
  }
}
