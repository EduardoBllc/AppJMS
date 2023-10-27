import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/product.dart';
import '../models/supplier.dart';

class ShowcaseManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Product> _productsList = [];

  final List<Supplier> _supplierList = [
    Supplier(name: 'Condor'),
    Supplier(name: 'Poli Joias'),
    Supplier(name: 'Brilhare'),
  ];

  List<Supplier> get supplierList => List.unmodifiable(_supplierList);

  void addSupplier(Supplier supplier) {
    _supplierList.add(supplier);
    notifyListeners();
  }

  void removeSupplier(Supplier supplier) {
    _supplierList.remove(supplier);
    notifyListeners();
  }

  List<Product> get productList => List.unmodifiable(_productsList);

  void addProduct(Product product) {
    _productsList.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _productsList.remove(product);
    notifyListeners();
  }

  void refreshFromCloud() async {
    var allDocs = await _firestore.collection('produtos').get();
    _productsList.clear();

    for (var doc in allDocs.docs) {
      Category category = Category.values.firstWhere((element) => element.name == doc['caracteristicas_produto']['categoria']);
      late DateTime boughtDate;

      try{
        Timestamp timestamp = doc['data_compra'] as Timestamp;
        int timestampMilli = timestamp.millisecondsSinceEpoch;
        boughtDate = DateTime.fromMillisecondsSinceEpoch(timestampMilli);
      }catch(e){
        print(e);
      }

      _productsList.add(
        Product(
          supplier: doc['dados_fabrica']['nome'],
          supplierCode: doc['dados_fabrica']['codigo'],
          category: category,
          description: doc['descricao'],
          cost: doc['precos']['custo'] / 1.0,
          upfrontValue: doc['precos']['vista'] / 1.0,
          deferredValue: doc['precos']['prazo'] / 1.0,
          boughtDate: boughtDate,
        ),
      );
    }
  }
}
