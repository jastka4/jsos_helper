import 'package:jsos_helper/common/db_provider.dart';
import 'package:jsos_helper/models/message.dart';

class MessageDao {
  Future<List<Message>> getAllMessages() async {
    final db = await DBProvider.db.database;
    var res = await db.query('message');
    List<Message> list =
        res.isNotEmpty ? res.map((c) => Message.fromMap(c)).toList() : [];
    return list;
  }
}
