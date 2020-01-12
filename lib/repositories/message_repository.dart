import 'package:jsos_helper/dao/message_dao.dart';
import 'package:jsos_helper/models/message.dart';

class MessageRepository {
  MessageDao _messageDao = MessageDao();

  Future<List<Message>> getAllMessages() => _messageDao.getAllMessages();
}
