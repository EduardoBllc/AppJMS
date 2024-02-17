import 'dart:developer';
import 'package:app_jms/services/firebase_services/generic_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/customers/customer.dart';
import '../../models/financial/sale.dart';

class FirebaseCustomersServices extends FirebaseServices {
  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      fetchCustomers() async {
    return await FirebaseServices.getAllCollectionDocs('clientes');
  }

  Future<Customer?> registerCustomer({
    required String name,
    required DateTime birthday,
    int? whatsapp,
    int? cellphone,
    String? email,
    Sale? lastPurchase,
  }) async {
    int? newCustomerId = await getNextCode('cliente');

    Customer newCustomer = Customer(
      id: newCustomerId!,
      name: name,
      birthday: birthday,
      whatsapp: whatsapp,
      email: email,
      lastPurchase: lastPurchase,
      registerDate: DateTime.now(),
    );

    Map<String, dynamic> newCustomerMap = newCustomer.toMap;

    try {
      await firestore
          .collection('clientes')
          .doc(newCustomerId.toString())
          .set(newCustomerMap);
      await stepInCode('clientes');
      return newCustomer;
    } on FirebaseException catch (e) {
      log('Erro ao cadastrar peça na Firestore');
      firebaseErrorLogger(e);
      return null;
    }
  }
}
