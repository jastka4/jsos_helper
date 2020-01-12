import 'package:jsos_helper/common/db_provider.dart';
import 'package:jsos_helper/models/payment.dart';

class PaymentDao {
  Future<List<Payment>> getAllPayments() async {
    final db = await DBProvider.db.database;
    var res = await db.query('payment');
    List<Payment> list =
        res.isNotEmpty ? res.map((c) => Payment.fromMap(c)).toList() : [];
    print(list);
    return list;
  }
}
