import 'dart:developer';
import 'package:app_jms/constants.dart';
import 'package:app_jms/services/firebase_services/generic_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices extends FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String?> logInUser({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    const String debugEmail = 'eduardo@jms.com';
    const String debugPassword = '20212510';

    log('Tentando logar usuário');
    try {
      await auth.signInWithEmailAndPassword(
        email: kDebugMode ? debugEmail : email.trim(),
        password: kDebugMode ? debugPassword : password.trim(),
      );
      log('Sucesso ao logar usuário');
      return null;
    } on FirebaseAuthException catch (e) {
      log('Erro ao tentar logar');
      log('Email e senha da tentativa:\n$email\n$password');
      log('Código: ${e.code}');
      log('Mensagem: ${e.message}');
      return e.code;
    }
  }

  static logOutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    log('Tentando deslogar usuário');
    try {
      await auth.signOut();
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
