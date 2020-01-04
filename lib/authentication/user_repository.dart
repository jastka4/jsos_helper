import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class UserRepository {
  final String _loginUrl =
      'https://edukacja.pwr.wroc.pl/EdukacjaWeb/logInUser.do';
  final String _logOutUrl =
      'https://edukacja.pwr.wroc.pl/EdukacjaWeb/logOutUser.do';

  final storage = FlutterSecureStorage();

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    var client = new http.Client();
    try {
      var accessPageResponse = await client
          .get('https://edukacja.pwr.wroc.pl/EdukacjaWeb/studia.do');
      var cookie = accessPageResponse.headers['set-cookie'];
      var token = parse(accessPageResponse.body)
          .querySelector("input[name='cl.edu.web.TOKEN']")
          .attributes['value'];

      var loginResponse = await client.post(_loginUrl, body: {
        'cl.edu.web.TOKEN': token,
        'login': username,
        'password': password
      }, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': cookie
      });

      // TODO - verify the response and create an exception
      if (parse(loginResponse.body).querySelector('.ZALOGOWANY') != null) {
        return token;
      } else {
        throw Exception("Wrong username or password!");
      }
    } finally {
      client.close();
    }
  }


  Future<void> deleteToken() async {
    // delete from keystore/keychain
    await storage.delete(key: 'jsos_helper');
    return;
  }

  Future<void> persistToken(String token) async {
    // write to keystore/keychain
//    await Future.delayed(Duration(seconds: 1)); // TODO - testing loading screen
    await storage.write(key: 'jsos_helper', value: token);
    return;
  }

  Future<bool> hasToken() async {
    // read from keystore/keychain
    String value = await storage.read(key: 'jsos_helper');
    return value != null;
  }
}
