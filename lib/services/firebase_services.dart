import 'dart:developer';
import 'package:app_jms/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllCollectionDocs(String collectionName) async {
    log('Buscando todos os documentos da coleçao $collectionName');
    var allDocs = await _firestore.collection('produtos').get();
    log('Foram encontrados ${allDocs.docs.length} documentos');
    return allDocs.docs;
  }

  Future<DocumentReference<Map<String, dynamic>>?> addProduct(
    Product newProduct,
  ) async {
    log('Registrando novo produto');

    var productMap = {
      'id': newProduct.code,
      'data_compra': newProduct.boughtDate,
      'descricao': newProduct.description,
      'caracteristicas': {
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
    };

    log('Detalhes do novo produto: $productMap');

    try {
      return await _firestore.collection('produtos').add(productMap);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<DocumentReference<Map<String, dynamic>>?> addSale(
      String collectionName, Product newProduct) async {
    try {
      return await _firestore.collection('produtos').add({
        'id': newProduct.code,
        'data_compra': newProduct.boughtDate,
        'descricao': newProduct.description,
        'caracteristicas': {
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
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<String?> logInUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  logOutUser() async {
    await _auth.signOut();
  }

  Future<String?> createNewUser(
      String username, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var collections = await _firestore.collection('usuarios').get();
      int newUserId = collections.docs.length;
      await _firestore.collection('usuarios').doc('user$newUserId').set({
        'email': email,
        'nome': username,
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
