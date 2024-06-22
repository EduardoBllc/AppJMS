import 'dart:developer';

import 'package:app_jms/services/firebase_services/customers_services.dart';
import 'package:flutter/cupertino.dart';

import '../../models/customers/customer.dart';
import '../utils.dart';

class CustomersCaretaker extends ChangeNotifier {
  final FirebaseCustomersServices _customersServices = FirebaseCustomersServices();

  final List<Customer> _customersList = [];

  List<Customer> get customersList => List.unmodifiable(_customersList);

  void getCustomers() async {
    var allDocs = await FirebaseCustomersServices.fetchCustomers();

    if (allDocs != null) {
      _customersList.clear();
    }

    for (var doc in allDocs!) {
      DateTime birthday = Helper.cloudTimeStampToDateTime(doc['data_aniversario']);
      DateTime registerDate = Helper.cloudTimeStampToDateTime(doc['data_cadastro']);

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

  Future<String?> createCustomer({
    required String name,
    required DateTime birthdate,
    String? whatsapp,
    String? cellphone,
    String? email,
  }) async {
    assert(whatsapp != null || cellphone != null || email != null, 'Pelo menos um contato deve ser fornecido.');
    try {
      Customer? newCustomer = await _customersServices.registerCustomer(
        name: name,
        birthday: birthdate,
        whatsapp: whatsapp,
        cellphone: cellphone,
      );
      log('Adicionando novo cliente na lista de clientes');
      if (newCustomer != null) {
        _customersList.add(newCustomer);
        notifyListeners();
        return null;
      } else {
        throw Exception('Erro ao registrar cliente');
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> removeProduct(int productId) async {
    try {
      await _customersServices.deleteCustomer(productId);
      log('Removendo cliente da lista de clientes');
      _customersList.remove(
        _customersList.firstWhere((element) => element.id == productId),
      );
      log('Cliente removido com sucesso');
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
