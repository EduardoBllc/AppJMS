import 'dart:developer';
import 'package:app_jms/services/firebase_services/stock_services.dart';
import 'package:app_jms/services/utils.dart';
import 'package:flutter/cupertino.dart';
import '../../models/utils/enums/category.dart';
import '../../models/utils/enums/metal.dart';
import '../../models/utils/enums/modality.dart';
import '../../models/stock/product.dart';
import '../../models/stock/supplier.dart';

class ShowcaseManager extends ChangeNotifier {
  FirebaseStockServices stockServices = FirebaseStockServices();

  final List<Product> _productsList = [];
  final List<Supplier> _supplierList = [
    Supplier(name: 'Condor'),
    Supplier(name: 'Poli'),
    Supplier(name: 'Brilhare'),
  ];

  List<Supplier> get supplierList => List.unmodifiable(_supplierList);

  List<Product> get productList => List.unmodifiable(_productsList);

  void addSupplier(Supplier supplier) {
    _supplierList.add(supplier);
    notifyListeners();
  }

  void removeSupplier(Supplier supplier) {
    _supplierList.remove(supplier);
    notifyListeners();
  }

  void getProducts() async {
    var allDocs = await FirebaseStockServices.fetchProducts();
    _productsList.clear();

    for (var doc in allDocs!) {
      Category category =
          Category.findItem(doc['caracteristicas']['categoria']);

      DateTime boughtDate = Helper.cloudTimeStampToDateTime(doc['data_compra']);

      _productsList.add(
        Product(
          id: doc['id'],
          supplier: _supplierList.firstWhere(
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

  Future<void> createProduct({
    required Supplier supplier,
    required String supplierCode,
    Modality modality = Modality.adult,
    required Category category,
    Metal metal = Metal.gold,
    required String description,
    required double cost,
    required double aVista,
    required double aPrazo,
    required DateTime boughtDate,
  }) async {
    try {
      Product? newProduct = await stockServices.registerProduct(
        boughtDate: boughtDate,
        supplier: supplier,
        supplierCode: supplierCode,
        modality: modality,
        category: category,
        metal: metal,
        description: description,
        cost: cost,
        aVista: aVista,
        aPrazo: aPrazo,
      );
      log('Adicionando nova peça na lista de produtos');
      if (newProduct != null) {
        _productsList.add(newProduct);
        notifyListeners();
      } else {
        throw Exception('Erro ao registrar produto');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> removeProduct(int productId) async {
    try {
      await stockServices.deleteProduct(productId);
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
