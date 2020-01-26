import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jsos_helper/common/storage_provider.dart';

class StorageRepository {
  final _storage =
      StorageProvider(flutterSecureStorage: new FlutterSecureStorage());

  Future<void> setUsername(String userData) => _storage.setUsername(userData);

  Future<void> deleteUsername() => _storage.deleteUsername();

  Future<String> getUsername() => _storage.getUsername();

  Future<void> setToken(String token) => _storage.setToken(token);

  Future<void> deleteToken() => _storage.deleteToken();

  Future<String> getToken() => _storage.getToken();

  Future<bool> hasToken() => _storage.hasToken();
}
