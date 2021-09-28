import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  // declaração do construtor para capturar os dados do produto a partir do Firebase.
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            // Carousel: animações diversas para imagens
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              // tamanho dos pontos de seleção da imagem
              dotSize: 4.0,
              // espaçamento entre os pontos
              dotSpacing: 15.0,
              // cor dos pontos
              dotBgColor: Colors.transparent,
              // mudança automática de imagem desligada
              autoplay: false,
            ), 
          ),
        ],
      ),
    );
  }
}