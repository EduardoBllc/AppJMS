import 'dart:developer';
import 'package:app_jms/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void firebaseErrorLogger(FirebaseException e) {
    log('Código do erro: ${e.code}');
    log('Mensagem: ${e.message}');
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getAllCollectionDocs(String collectionName) async {
    log('Buscando todos os documentos da coleçao $collectionName');
    try {
      var allDocs = await _firestore.collection('produtos').get();
      log('Foram encontrados ${allDocs.docs.length} documentos');
      return allDocs.docs;
    } on FirebaseException catch (e) {
      log('Erro ao procurar documentos');
      firebaseErrorLogger(e);
      return null;
    }
  }

  Future<CollectionReference<Map<String, dynamic>>?>
      accessControlTable() async {
    log('Entrando na tabela de controle');
    try {
      return _firestore.collection('controle');
    } on FirebaseException catch (e) {
      log('Erro ao capturar próximo código');
      firebaseErrorLogger(e);
      return null;
    }
  }

  Future<int?> getNextCode(String item) async {
    try {
      var controlTable = await accessControlTable();
      log('Capturando o próximo código de produto');
      var itemTable = await controlTable!.doc(item).get();
      return itemTable['total'];
    } on FirebaseException catch (e) {
      log('Erro ao capturar próximo código');
      firebaseErrorLogger(e);
      return null;
    }
  }

  Future<String?> stepInCode(String item) async {
    try {
      var controlTable = await accessControlTable();
      log('Tentando passar para próximo código de $item na tabela de controle');
      var itemTable = await controlTable!.doc(item).get();
      int newCode = itemTable['total'] + 1;
      await controlTable.doc(item).update({'total': newCode});
      return null;
    } on FirebaseException catch (e) {
      log('Erro ao passar para próximo código da tabela de $item');
      firebaseErrorLogger(e);
      return e.message;
    }
  }

  Future<String?> addProduct(
    Product newProduct,
  ) async {
    log('Registrando nova peça na Firestore');

    var productMap = {
      'id': newProduct.id,
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

    log('Detalhes da nova peça: $productMap');

    try {
      await _firestore
          .collection('produtos')
          .doc(newProduct.id.toString())
          .set(productMap);
      await stepInCode('produtos');
      return null;
    } on FirebaseException catch (e) {
      log('Erro ao cadastrar peça na Firestore');
      firebaseErrorLogger(e);
      return e.message;
    }
  }

  Future<String?> removeProduct(int productCode) async {
    log('Removendo peça código $productCode');
    try {
      await _firestore
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

  Future<String?> logInUser({
    required String email,
    required String password,
  }) async {
    log('Tentando logar usuário');
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      log('Sucesso ao logar usuário');
      return null;
    } on FirebaseAuthException catch (e) {
      log('Erro ao tentar logar');
      log('Email e senha da tentativa:\n$email\n$password');
      firebaseErrorLogger(e);
      return e.code;
    }
  }

  logOutUser() async {
    log('Tentando deslogar usuário');
    try {
      await _auth.signOut();
      log('Sucesso ao deslogar');
    } on FirebaseAuthException catch (e) {
      log('Erro ao tentar deslogar');
      log('Código: ${e.code}');
      log('Mensagem: ${e.message}');
      return e.message;
    }
  }

  Future<String?> createNewUser(
      String username, String email, String password) async {
    log('Tentando criar novo usuário...');
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var collections = await _firestore.collection('usuarios').get();
      int newUserId = collections.docs.length;
      await _firestore.collection('usuarios').doc('user$newUserId').set({
        'email': email.trim(),
        'nome': username,
      });
      log('Sucesso ao criar novo usuário:');
      log('Nome: $username');
      log('Email: $email');
      log('Senha: $password');
      return null;
    } on FirebaseAuthException catch (e) {
      log('Erro ao criar novo usuário');
      firebaseErrorLogger(e);
      return e.message;
    }
  }
}
