// import do Future
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// modelo criado para cuidar apenas dos usuários
// Model é basicamente um objeto que vai guardar estados de uma determinada função
class UserModel extends Model {
  // usuário atual

  FirebaseAuth _auth = FirebaseAuth.instance;
  User firebaseUser;

  // mapa para guardar dados importantes do usuário
  Map<String, dynamic> userData = Map();

  // variavel para indicar se algo está processando
  bool isLoading = false;

  // facilitação para acesso ao ScopedModel de qualquer parte
  // of é o nome do método
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  get email => null;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadUser();
  }

  // criar conta
  // @required anotação para requerer parâmetro (obrigatório)
  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
      email: userData['email'],
      password: pass,
    )
        .then((user) async {
      // salvando usuário
      firebaseUser = user.user;
      print(user);
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();

      // em caso de falha retorna um erro
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  //login do usuário
  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      // forma correta de capturar dados do usuário do Firebase = user.user;
      firebaseUser = user.user;

      await _loadUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
      
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    // indicar que é um usuário vazio
    userData = Map();

    // não tem ninguém logado
    firebaseUser = null;

    // estado modificado
    notifyListeners();
  }

  // recuperar senha
  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  // função para salvar os dados do usuário no Firebase
  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .set(userData);
  }

  //está logado ou não
  bool isLogged() {
    return firebaseUser != null;
  }

  // método para carregar usuário atual automaticamente
  Future<Null> _loadUser() async {
    if (firebaseUser == null) firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      // capturando do Firebase usuário criado
      if (userData['name'] == null) {
        // captura e exibição do nome do usuário na conta
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
        userData = docUser.data();
        // userData = docUser.data as Map<String, dynamic>;
      }
    }
    notifyListeners();
  }
}
