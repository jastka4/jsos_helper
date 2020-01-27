import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/dao/user_dao.dart';
import 'package:jsos_helper/models/user.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final UserDao _userDao = new UserDao();

  Future<String> authenticate({
    @required String username,
    @required String password,
    @required University university,
  }) async {
    // TODO - authenticate users
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<User> getUser(username) => _userDao.getUser(username);
}
