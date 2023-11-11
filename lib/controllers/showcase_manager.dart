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
          code: doc['codigo'].toString(),
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


  Future<void> registerProduct(Product product) async {

    try{
      var snapshots = await _firestore.collection('produtos').get();
      int actualKey = snapshots.docs.length;

      await _firestore.collection('produtos').add({
        'codigo' : actualKey,
        'data_compra' : product.boughtDate,
        'descricao' : product.description,
        'caracteristicas_produto' : {
          'categoria' : product.category.name,
          'metal' : product.metal.name,
          'modalidade' : product.modality.name,
        },
        'dados_fabrica' : {
          'codigo' : product.supplierCode,
          'nome' : product.supplier.name,
        },
        'precos' : {
          'custo' : product.cost,
          'vista' : product.aVista,
          'prazo' : product.aPrazo,
        },
      });
    }catch (e){
      print(e);
    }
    _productsList.add(product);
  }
}
