import 'package:app_jms/services/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/product.dart';
import '../models/supplier.dart';
import '../services/firebase_services.dart';

class ShowcaseManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseServices _firebaseServices = FirebaseServices();
  final Helper _helper = Helper();

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

  void refreshFromCloud() async {
    var allDocs = await _firebaseServices.getAllCloudDocs('produtos');
    _productsList.clear();

    for (var doc in allDocs) {
      Category category = Category.findItem(doc['caracteristicas_produto']['categoria']);

      DateTime boughtDate = _helper.cloudTimeStampToDateTime(doc['data_compra']);

      _productsList.add(
        Product(
          code: doc['codigo'],
          supplier: supplierList.firstWhere((element) => element.name == doc['dados_fabrica']['nome']),
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
      var snapshots = await _firebaseServices.getAllCloudDocs('produtos');

      int actualKey = snapshots.length;

      Product newProduct = Product(
        code: actualKey,
        supplier: supplier,
        supplierCode: supplierCode,
        category: category,
        description: description,
        cost: cost,
        aVista: aVista,
        aPrazo: aPrazo,
        boughtDate: boughtDate,
      );

      await _firestore.collection('produtos').add({
        'codigo': actualKey,
        'data_compra': boughtDate,
        'descricao': description,
        'caracteristicas_produto': {
          'categoria': category.name,
          'metal': metal.name,
          'modalidade': modality!.name,
        },
        'dados_fabrica': {
          'codigo': supplierCode,
          'nome': supplier.name,
        },
        'precos': {
          'custo': cost,
          'vista': aVista,
          'prazo': aPrazo,
        },
      });
      _productsList.add(newProduct);
    } catch (e) {
      // log(e);
    }
  }
}
