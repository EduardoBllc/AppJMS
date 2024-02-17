import 'package:app_jms/services/firebase_services/customers_services.dart';
import 'package:flutter/cupertino.dart';
import '../../models/customers/customer.dart';
import '../utils.dart';

class CustomersCaretaker extends ChangeNotifier {
  final FirebaseCustomersServices _customersServices =
      FirebaseCustomersServices();

  final List<Customer> _customersList = [];

  List<Customer> get customersList => List.unmodifiable(_customersList);

  void getCustomers() async {
    var allDocs = await FirebaseCustomersServices.fetchCustomers();

    if (allDocs != null) {
      _customersList.clear();
    }

    for (var doc in allDocs!) {
      DateTime birthday =
          Helper.cloudTimeStampToDateTime(doc['data_aniversario']);
      DateTime registerDate =
          Helper.cloudTimeStampToDateTime(doc['data_cadastro']);

      _customersList.add(
        Customer(
          id: doc['id'],
          name: doc['nome'],
          birthday: birthday,
          whatsapp: doc['whatsapp'],
          cellphone: doc['celular'],
          email: doc['email'],
          registerDate: registerDate,
        ),
      );
    }
  }
}
