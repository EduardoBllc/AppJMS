import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/utils/enums/category.dart';
import '../../models/utils/enums/metal.dart';
import '../../models/utils/enums/modality.dart';
import '../../models/stock/product.dart';
import '../../models/stock/supplier.dart';
import 'generic_services.dart';

class FirebaseStockServices extends FirebaseServices {
  Future<Product?> createProduct({
    required DateTime boughtDate,
    required Supplier supplier,
    required String supplierCode,
    required Modality modality,
    required Category category,
    required Metal metal,
    required String description,
    required double cost,
    required double aVista,
    required double aPrazo,
  }) async {
    int? newProductId = await getNextCode('produtos');

    log('Registrando nova peça na Firestore');

    Product newProduct = Product(
      id: newProductId!,
      supplier: supplier,
      supplierCode: supplierCode,
      category: category,
      description: description,
      cost: cost,
      aVista: aVista,
      aPrazo: aPrazo,
      boughtDate: boughtDate,
    );

    Map<String, dynamic> productMap = newProduct.toMap;

    log('Detalhes da nova peça: $productMap');

    try {
      await firestore
          .collection('produtos')
          .doc(newProduct.id.toString())
          .set(productMap);
      await stepInCode('produtos');
      return newProduct;
    } on FirebaseException catch (e) {
      log('Erro ao cadastrar peça na Firestore');
      firebaseErrorLogger(e);
      return null;
    }
  }

  Future<String?> deleteProduct(int productCode) async {
    log('Removendo peça código $productCode');
    try {
      await firestore
          .collection('produtos')
          .doc(productCode.toString())
          .delete();
      log('peça removida da firestore com sucesso');
      return null;
    } on FirebaseException catch (e) {
      log('Erro ao remover produto');
      firebaseErrorLogger(e);
      return e.message;
    }
  }
}
