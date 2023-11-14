import 'dart:developer';
import 'package:app_jms/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllCloudDocs(String collectionName) async{
    log('Buscando todos os documentos da coleçao $collectionName');
    var allDocs = await _firestore.collection('produtos').get();
    log('Foram encontrados ${allDocs.docs.length} documentos');
    return allDocs.docs;
  }

  Future<DocumentReference<Map<String, dynamic>>?> addToCollection(String collectionName, Product newProduct) async {
    try {
      return await _firestore.collection('produtos').add({
        'codigo': newProduct.code,
        'data_compra': newProduct.boughtDate,
        'descricao': newProduct.description,
        'caracteristicas_produto': {
          'categoria': newProduct.category.name,
          'metal': newProduct.metal.name,
          'modalidade': newProduct.modality.name,
        },
        'dados_fabrica': {
          'codigo': newProduct.supplierCode,
          'nome': newProduct.supplier.name,
        },
        'precos': {
          'custo': newProduct.cost,
          'vista': newProduct.aVista,
          'prazo': newProduct.aPrazo,
        },
      });
    }catch(e){
      log(e.toString());
      return null;
    }
  }
}
