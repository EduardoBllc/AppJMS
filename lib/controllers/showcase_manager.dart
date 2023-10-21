import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/product.dart';
import '../models/supplier.dart';

class ShowcaseManager extends ChangeNotifier{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Product> _productsList = [];

  final List<Supplier> _supplierList = [
    Supplier(name: 'Condor'),
    Supplier(name: 'Poli Joias'),
    Supplier(name: 'Brilhare'),
  ];

  List<Supplier> get supplierList => List.unmodifiable(_supplierList);

  void addSupplier(Supplier supplier){
    _supplierList.add(supplier);
    notifyListeners();
  }

  void removeSupplier(Supplier supplier){
    _supplierList.remove(supplier);
    notifyListeners();
  }

  List<Product> get productList => List.unmodifiable(_productsList);

  void addProduct(Product product){
    _productsList.add(product);
    notifyListeners();
  }

  void removeProduct(Product product){
    _productsList.remove(product);
    notifyListeners();
  }
  
  void getCloudProducts() async {
    var allDocs = await _firestore.collection('produtos').get();

    for(var doc in allDocs.docs){
      print(doc);
    }
  }
}
