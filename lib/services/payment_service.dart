import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsos_helper/common/global_constants.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/models/payment.dart';

class PaymentService {
  static const URL = GlobalConstants.BASE_API_URL + '/payments';

  Future<List<Payment>> fetchPayments(
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
      return _parsePayments(response.body);
    } else {
      throw Exception('Unable to fetch payments from the REST API');
    }
  }

  List<Payment> _parsePayments(String responseBody) {
    final parsed = json.decode(responseBody)["payments"];
    return parsed.isNotEmpty
        ? parsed.map<Payment>((i) => Payment.fromJson(i)).toList()
        : [];
  }
}
