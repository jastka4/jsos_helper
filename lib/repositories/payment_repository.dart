import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/dao/payment_dao.dart';
import 'package:jsos_helper/models/payment.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:jsos_helper/services/payment_service.dart';
import 'package:meta/meta.dart';

class PaymentRepository {
  final PaymentDao _paymentDao = new PaymentDao();
  final PaymentService _paymentService = new PaymentService();
  final StorageRepository storageRepository;

  PaymentRepository({@required this.storageRepository});

  Future<List<Payment>> getAllPayments() async {
    String username = await storageRepository.getUsername();
    University university = await storageRepository.getUniversity();
    return await _paymentService.fetchPayments(username, university);
//    _paymentDao.getAllPayments();
  }
}
