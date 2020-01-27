import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jsos_helper/common/global_constants.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/models/user.dart';

class UserService {
  static const LOGIN_URL = GlobalConstants.BASE_API_URL + '/login';
  static const USER_URL = GlobalConstants.BASE_API_URL + '/user';

  Future<String> loginUser({
    @required String username,
    @required String password,
    @required University university,
  }) async {
    final response = await http.post(
      LOGIN_URL,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'username': username,
          'password': password,
          'university': university.abbreviation,
        },
      ),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['token'];
    } else {
      throw Exception('Unable to login user using the REST API');
    }
  }

  Future<User> fetchUserData(String username, University university) async {
    final response = await http.post(
      USER_URL,
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
      return _parseUserData(
        responseBody: response.body,
        university: university,
      );
    } else {
      throw Exception('Unable to fetch user data from the REST API');
    }
  }

  User _parseUserData({
    @required String responseBody,
    @required University university,
  }) {
    final Map<String, dynamic> map = json.decode(responseBody);
    map['university'] = university.index;
    return User.fromJson(map);
  }
}
