import 'dart:developer';

import 'package:app_jms/services/firebase_services/generic_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/customers/customer.dart';

class FirebaseCustomersServices extends FirebaseServices {
  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> fetchCustomers() async {
    return await FirebaseServices.getAllCollectionDocs('clientes');
  }

  Future<Customer?> registerCustomer({
    required String name,
    required DateTime birthday,
    String? whatsapp,
    String? cellphone,
    String? email,
  }) async {
    int? newCustomerId = await getNextCode('cliente');

    Customer newCustomer = Customer(
      id: newCustomerId!,
      name: name,
      birthday: birthday,
      whatsapp: whatsapp,
      email: email,
      registerDate: DateTime.now(),
    );

    Map<String, dynamic> newCustomerMap = newCustomer.toMap;

    try {
      await firestore.collection('clientes').doc(newCustomerId.toString()).set(newCustomerMap);
      await stepInCode('clientes');
      return newCustomer;
    } on FirebaseException catch (e) {
      log('Erro ao cadastrar peça na Firestore');
      firebaseErrorLogger(e);
      return null;
    }
  }

  Future<String?> deleteCustomer(int customerCode) async {
    log('Removendo cliente código $customerCode');
    try {
      await firestore.collection('clientes').doc(customerCode.toString()).delete();
      log('Cliente removido da firestore com sucesso');
      return null;
    } on FirebaseException catch (e) {
      log('Erro ao remover cliente');
      firebaseErrorLogger(e);
      return e.message;
    }
  }
}
