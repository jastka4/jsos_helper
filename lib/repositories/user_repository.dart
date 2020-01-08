import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final storage = FlutterSecureStorage();

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    // TODO - authenticate users
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    // delete from keystore/keychain
    await storage.delete(key: 'jsos_helper');
    return;
  }

  Future<void> persistToken(String token) async {
    // write to keystore/keychain
    await storage.write(key: 'jsos_helper', value: token);
    return;
  }

  Future<bool> hasToken() async {
    // read from keystore/keychain
    String value = await storage.read(key: 'jsos_helper');
    return value != null;
  }
}
