import 'package:jsos_helper/common/db_provider.dart';
import 'package:jsos_helper/models/user.dart';

class UserDao {
  Future<User> getUser(String username) async {
    final db = await DBProvider.db.database;
    var res = await db.query('user');
    if (res.length == 1) {
      return res.isNotEmpty ? User.fromMap(res[0]) : null;
    }
    return null;
  }
}
