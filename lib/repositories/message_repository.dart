import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/dao/message_dao.dart';
import 'package:jsos_helper/models/message.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:jsos_helper/services/message_service.dart';
import 'package:meta/meta.dart';

class MessageRepository {
  MessageDao _messageDao = MessageDao();
  MessageService _messageService = MessageService();

  final StorageRepository storageRepository;

  MessageRepository({@required this.storageRepository});

  Future<List<Message>> getAllMessages() async {
    String username = await storageRepository.getUsername();
    University university = await storageRepository.getUniversity();
    return _messageService.fetchMessages(username, university);
//    _messageDao.getAllMessages();
  }
}
