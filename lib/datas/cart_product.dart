import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_online/datas/product_data.dart';

class CartProduct {

  // cid = cart product id
  String cid;
  String category;

  // product id
  String pid;
  int qtde;
  String size;

  ProductData prodData;

  CartProduct();

  // vai receber os produtod do carrinho e transformar em um cart product
  // captura de informações do produto
  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = document['category'];
    pid = document['pid'];
    qtde = document['qtde'];
    size = document['size'];
  }

  // solução de erro do productData?.resumeMap()
  //get productData => null;

  // após adicionar produtos ao carrinho, transforma em um mapa
  // será exibido as informações do produto
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'pid': pid,
      'qtde': qtde,
      'size': size,
      'product': prodData.resumeMap()
    };
  }
}