import 'package:jsos_helper/dao/payment_dao.dart';
import 'package:jsos_helper/models/payment.dart';

class PaymentRepository {
  final PaymentDao _paymentDao = new PaymentDao();

  Future<List<Payment>> getAllPayments() => _paymentDao.getAllPayments();
}
