import 'dart:developer';
import 'package:app_jms/services/utils.dart';
import 'package:flutter/cupertino.dart';
import '../../models/product.dart';
import '../../models/supplier.dart';
import '../firebase_services.dart';

class ShowcaseManager extends ChangeNotifier {
  final FirebaseServices _firebaseServices = FirebaseServices();

  final List<Product> _productsList = [];
  final List<Supplier> _supplierList = [
    Supplier(name: 'Condor'),
    Supplier(name: 'Poli'),
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

  void getProducts() async {
    var allDocs = await _firebaseServices.getAllCollectionDocs('produtos');
    _productsList.clear();

    for (var doc in allDocs!) {
      Category category =
          Category.findItem(doc['caracteristicas']['categoria']);

      DateTime boughtDate = Helper.cloudTimeStampToDateTime(doc['data_compra']);

      _productsList.add(
        Product(
          id: doc['id'],
          supplier: supplierList.firstWhere(
              (element) => element.name == doc['dados_fabrica']['nome']),
          supplierCode: doc['dados_fabrica']['codigo'].toString(),
          category: category,
          description: doc['descricao'],
          cost: doc['precos']['custo'] / 1.0,
          aVista: doc['precos']['vista'] / 1.0,
          aPrazo: doc['precos']['prazo'] / 1.0,
          boughtDate: boughtDate,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> registerProduct({
    required Supplier supplier,
    required String supplierCode,
    Modality? modality = Modality.adult,
    required Category category,
    Metal metal = Metal.gold,
    required String description,
    required double cost,
    required double aVista,
    required double aPrazo,
    required DateTime boughtDate,
  }) async {
    try {
      int actualKey = (await _firebaseServices.getNextCode('produtos'))!;
      Product newProduct = Product(
        id: actualKey,
        supplier: supplier,
        supplierCode: supplierCode,
        category: category,
        description: description,
        cost: cost,
        aVista: aVista,
        aPrazo: aPrazo,
        boughtDate: boughtDate,
      );

      await _firebaseServices.addProduct(newProduct);
      log('Adicionando nova peça na lista de produtos');
      _productsList.add(newProduct);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> removeProduct(int productId) async {
    try {
      await _firebaseServices.removeProduct(productId);
      log('Removendo peça da lista de produtos');
      _productsList.remove(
        _productsList.firstWhere((element) => element.id == productId),
      );
      log('Peça removida com sucesso');
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
