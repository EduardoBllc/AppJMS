import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/utils/mixins/loggable.dart';
import '../../models/utils/mixins/mappable.dart';
import '../../models/utils/mixins/registerable.dart';

abstract class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;

  void firebaseErrorLogger(FirebaseException e) {
    log('Código do erro: ${e.code}');
    log('Mensagem: ${e.message}');
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getAllCollectionDocs(String collectionName) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    log('Buscando todos os documentos da coleçao $collectionName');
    try {
      var allDocs = await firestore.collection('produtos').get();
      log('Foram encontrados ${allDocs.docs.length} documentos');
      return allDocs.docs;
    } on FirebaseException catch (e) {
      log('Erro ao procurar documentos');
      log(e.message.toString());
      return null;
    }
  }

  Future<CollectionReference<Map<String, dynamic>>?>
      accessControlTable() async {
    log('Entrando na tabela de controle');
    try {
      return firestore.collection('controle');
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

  Future<String?> registerObject<T extends Registerable>(
      Mappable object, String collection, int id) async {
    try {
      await firestore
          .collection(collection)
          .doc(id.toString())
          .set(object.toMap);
      await stepInCode(collection);
      if (object is Loggable) {
        log('Objeto do tipo $T: ${object.log}');
      }
      return null;
    } on FirebaseException catch (e) {
      log('Erro ao tentar cadastrar item na tabela $collection');
      firebaseErrorLogger(e);
      return e.message;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }
}
