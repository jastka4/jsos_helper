import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class StorageProvider {
  StorageProvider({@required this.flutterSecureStorage})
      : assert(flutterSecureStorage != null);

  final FlutterSecureStorage flutterSecureStorage;

  static const String storageUsernameKey = 'username';
  static const String storageTokenKey = 'token';

  Future<void> setUsername(String userData) async {
    await flutterSecureStorage.write(key: storageUsernameKey, value: userData);
  }

  Future<void> deleteUsername() async {
    await flutterSecureStorage.delete(key: storageUsernameKey);
  }

  Future<String> getUsername() async {
    return await flutterSecureStorage.read(key: storageUsernameKey);
  }

  Future<void> setToken(String token) async {
    await flutterSecureStorage.write(key: storageTokenKey, value: token);
    return;
  }

  Future<void> deleteToken() async {
    await flutterSecureStorage.delete(key: storageTokenKey);
    return;
  }

  Future<String> getToken() async {
    return await flutterSecureStorage.read(key: storageTokenKey);
  }

  Future<bool> hasToken() async {
    String value = await flutterSecureStorage.read(key: storageTokenKey);
    return value != null;
  }
}
