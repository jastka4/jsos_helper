import 'package:jsos_helper/common/connection_status_singleton.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/dao/user_dao.dart';
import 'package:jsos_helper/models/user.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:jsos_helper/services/user_service.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final UserDao _userDao = new UserDao();
  final UserService _userService = new UserService();
  final StorageRepository storageRepository;

  UserRepository({@required this.storageRepository});

  Future<String> authenticate({
    @required String username,
    @required String password,
    @required University university,
  }) =>
      _userService.loginUser(
        username: username,
        password: password,
        university: university,
      );

  Future<User> getUser() async {
    String username = await storageRepository.getUsername();
    University university = await storageRepository.getUniversity();
    if (await ConnectionStatusSingleton.getInstance().checkConnection()) {
      return await _userService.fetchUserData(username, university);
    } else {
      return _userDao.getUser(username);
    }
  }
}
