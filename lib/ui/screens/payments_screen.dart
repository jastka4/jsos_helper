import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jsos_helper/common/color_helper.dart';
import 'package:jsos_helper/models/payment.dart';
import 'package:jsos_helper/repositories/payment_repository.dart';
import 'package:jsos_helper/ui/components/custom_card.dart';
import 'package:jsos_helper/ui/components/loading_indicator.dart';

// TODO - add payment details screen?
class PaymentsScreen extends StatelessWidget {
  final String title;
  final PaymentRepository _paymentRepository = PaymentRepository();

  PaymentsScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 16.0),
          Expanded(child: _buildPaymentList()),
        ],
      ),
    );
  }

  Widget _buildPaymentList() {
    return FutureBuilder<List<Payment>>(
      future: _paymentRepository.getAllPayments(),
      builder: (BuildContext context, AsyncSnapshot<List<Payment>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('You have no payments'),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Payment payment = snapshot.data[index];
                  return _buildPayment(payment);
                });
          }
        } else {
          return LoadingIndicator();
        }
      },
    );
  }

  Widget _buildPayment(Payment payment) {
    final NumberFormat _numberFormat =
        new NumberFormat.currency(locale: 'pl_PL', symbol: 'zł');
    final DateFormat _dateFormat = DateFormat("dd.MM.yyyy");

    return CustomCard(
      asideWidgets: <Widget>[
        Text(_numberFormat.format(payment.value)),
      ],
      leftWidgets: <Widget>[
        Text(payment.title),
        payment.instalment != null
            ? Text('Instalment: ${payment.instalment.toString()}')
            : Container()
      ],
      rightWidgets: <Widget>[
        Text(_dateFormat.format(payment.paymentDate)),
        Text(describeEnum(payment.status)),
      ],
      color: ColorHelper.getPaymentColor(payment.status),
    );
  }
}
