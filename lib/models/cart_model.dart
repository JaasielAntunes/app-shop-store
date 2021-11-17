import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/datas/cart_product.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  UserModel user;
  
  List<CartProduct> products = [];

  // código do cupom
  String couponCode;

  // percentual de desconto
  int discount = 0;

  bool isLoading = false;

  CartModel(this.user) {
    if(user.isLogged())
    _loadCartItems();
  }

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  // adicionar item ao carrinho
  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    // acessando dados a partir do Firebase
    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).collection('cart').
    add(cartProduct.toMap()).then((doc) { 
    // ao adicionar produto ao carrinho captura o id fornecido pelo Firebase e salva no cartProduct
      cartProduct.cid = doc.id;
    });

    // exibir os items adicionados ao carrinho
    notifyListeners();
  }

  // remover item do carrinho
  void removeCartItem(CartProduct cartProduct) {

    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).collection('cart').
    doc(cartProduct.cid).delete();

    products.remove(cartProduct);
    notifyListeners();
  } 

  // função para decrementar item do carrinho
  void decProduct(CartProduct cartProduct) {
    cartProduct.qtde--;

    // atualizar produto no banco de dados
    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).collection('cart').
    doc(cartProduct.cid).update(cartProduct.toMap()); 

    notifyListeners();
  }

  // função para incrementar item do carrinho
  void incProduct(CartProduct cartProduct) {
    cartProduct.qtde++;

    // atualizar produto no banco de dados
    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).collection('cart').
    doc(cartProduct.cid).update(cartProduct.toMap()); 

    notifyListeners();
  }

  void _loadCartItems() async {

    // obter todos os documentos do banco de dados
    // cada documento corresponde a um item do carrinho
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).collection('cart').
    get();

    // transformando cada documento do banco de dados em um CartProduct
    // e retornando uma lista
    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

  // função finalizar pedido
  Future<String> finishOrder() async {

    if(products.length == 0) return null;

    isLoading = true;

    // aparecer na tela o circulo girando
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    // obtendo informações do pedido para salvar no usuário
    DocumentReference refOrder = await FirebaseFirestore.instance.collection('orders').add(
      {
        'clientId': user.firebaseUser.uid,
        'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
        'shipPrice': shipPrice,
        'productsPrice': productsPrice,
        'discount': discount,
        'totalPrice': productsPrice - discount + shipPrice,
        'status': 1,
      }
    );

    // salvando orderId dentro do usuário
    await FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).collection('orders').
    doc(refOrder.id).set(
      {
        'orderId': refOrder.id
      }
    );

    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).
    collection('cart').get();

    // deletar todos os produtos do carrinho
    for(DocumentSnapshot doc in query.docs) {
      doc.reference.delete();
    }

    products.clear();

    couponCode = null;
    discount = 0;

    isLoading = false;
    notifyListeners();

    // ser possivel mostrar tela de confirmação de pedido
    return refOrder.id;

  }

  // função para aplicar cupom
  void applyCoupon(String couponCode, int discount) {

    this.couponCode = couponCode;
    this.discount = discount;
  }

  // atualizar imediatamente preços no carrinho
  void updatePrices() {

    notifyListeners();
  }

  // calcular o subtotal
  double getProductsPrice() {

    double price = 0.0;
    for(CartProduct c in products) {
      if(c.prodData != null) 
        price += c.qtde * c.prodData.price;
      
    }

    return price;
  }

  // calcular o desconto
  double getDiscount() {

    return getProductsPrice() * discount / 100;
  }

  // calcular o frete
  double getShipPrice() {

    return 19.99;
  }
}